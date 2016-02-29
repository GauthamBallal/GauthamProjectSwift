//
//  ViewController.swift
//  GKBDataConverter
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

#import "GKBDataConverter.h"
#import "GKBCoreData.h"
#import "DesignSwift-Swift.h"
#import "DesignPatternSwift-Bridging-Header.h"

@implementation GKBDataConverter
@synthesize colourData,wallpaperData;


- (id)init
{
    return [self initWithTestsData:@"MtechProject" andQuestsionsData:nil];
}

/**
This method returns self after creating wallpaper and color data
 
@param colourFile - name of the file containing colour information
@param wallpaperFile - name of the file containing wallpaper information
@return id - self
 */
- (id)initWithTestsData:(NSString *)testsFile andQuestsionsData:(NSString*)questionsFile
{
    
    if ((self = [super init])) {
        
        // Attempt to load the entirety of each file as their own strings
        // or error out if any file fails
        NSError *err = nil;
        
        testsFile = [[NSBundle mainBundle] pathForResource:testsFile ofType:@"csv"];
        
        testsData = [[NSString alloc] initWithContentsOfFile:testsFile encoding:NSMacOSRomanStringEncoding error:&err];
        if (err) {
            NSLog(@"Error opening problems export: %@", err.localizedDescription);
            return nil;
        }
        if(questionsFile)
        {
            questionsFile = [[NSBundle mainBundle] pathForResource:questionsFile ofType:@"csv"];
            questionsData = [[NSString alloc] initWithContentsOfFile:questionsFile encoding:NSMacOSRomanStringEncoding error:&err];
        }

        if (err) {
            NSLog(@"Error opening problems export: %@", err.localizedDescription);
            return nil;
        }
    }
    
    return self;
}

-(void)createThisTestIfNotCreatedWithQuestion:(GKBQuestion*)question
{
    NSManagedObjectContext *context = [[GKBCoreData sharedCoreDataObject] managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"GKBTest" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = pred = [NSPredicate predicateWithFormat:@"(testID = %@)",question.testID];
    [request setPredicate:pred];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    GKBTest *test = nil;
    if ([objects count] > 0)
    {
        test = [objects objectAtIndex:0];
    }
    else
    {
        test = [NSEntityDescription insertNewObjectForEntityForName:@"GKBTest" inManagedObjectContext:context];
        test.testID = question.testID;
        test.testDescription = question.testDescription;
        test.testName = question.testName;
    }
    question.test = test;
    [test addQuestionsObject:question];
}

/**
 This method checks if the color passed is present in the database
 
 @param colour - color to be searched
 @param dataBaseName - database to be searched in
 @return BOOL - status of check
 */
-(BOOL)checkIfQuestionIsAdded:(NSDictionary*)object
{
    NSManagedObjectContext *context = [[GKBCoreData sharedCoreDataObject] managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"GKBQuestion"
                                                  inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = nil;
    ;
    pred = [NSPredicate predicateWithFormat:@"(questionID = %@) AND (testID = %@)",object[[GKBConstants kCDQuestionID]],object[[GKBConstants kCDTestID]]];

    [request setPredicate:pred];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if ([objects count] == 0)
        return NO;
    else
        return YES;
        
}


/**
 This method creates the database based on colorData and wallPaperData
 
 @return BOOL - status of export
 */
- (BOOL)exportFilesToCoreData
{
    NSError *err = nil;
    BOOL success = YES;
    
    
    NSManagedObjectContext *moc = [[GKBCoreData sharedCoreDataObject] managedObjectContext];

    NSArray *products = [self parseTestsToArray:testsData];
    for (NSDictionary *productDict in products) {
        if (![self checkIfQuestionIsAdded:productDict])
        {
            GKBQuestion *question = [NSEntityDescription insertNewObjectForEntityForName:@"GKBQuestion" inManagedObjectContext:moc];
            question.testID = [NSNumber numberWithInt:[[productDict objectForKey:[GKBConstants kCDTestID]] intValue]];
            question.testName = [productDict objectForKey:[GKBConstants kCDTestName]];
            question.testDescription = [productDict objectForKey:[GKBConstants kCDTestDescription]];
            question.question = [productDict objectForKey:[GKBConstants kCDQuestion]];
            question.questionID = [NSNumber numberWithInt:[[productDict objectForKey:[GKBConstants kCDQuestionID]] intValue]];
            question.optionOne = [NSString stringWithFormat:@"1. %@",[productDict objectForKey:[GKBConstants kCDQuestionOption1]]];
            question.optionTwo = [NSString stringWithFormat:@"2. %@",[productDict objectForKey:[GKBConstants kCDQuestionOption2]]];
            question.optionThree = [NSString stringWithFormat:@"3. %@",[productDict objectForKey:[GKBConstants kCDQuestionOption3]]];
            question.optionFour = [NSString stringWithFormat:@"4. %@",[productDict objectForKey:[GKBConstants kCDQuestionOption4]]];
            question.correctAnswer = [productDict objectForKey:[GKBConstants kCDQuestionCorrectAnswer]];
            question.hint = [productDict objectForKey:[GKBConstants kCDQuestionHint]];
            
            [self createThisTestIfNotCreatedWithQuestion:question];
        }
    }
    
    
    err = nil;
    [moc save:&err];
    
    if (err) {
        NSLog(@"ERROR SAVING: %@", err.localizedDescription);
    }
    else {
        NSLog(@"COMPLETE!");
    }
    return success;
}

/**
 Takes raw string input from a CSV file and converts each row into a separate dictionary organized into an array
 
 @param str - string which needs to be parsed

 @return NSArray - array containing all data in a formated manner
 */
- (NSArray *)parseTestsToArray:(NSString *)str
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *rows = [self parseIntoRowsCols:str];
    
    for (NSArray *cols in rows) {
        
        // Skip first set since it is just header values
        if ([rows indexOfObject:cols] == 0) {
            continue;
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        for (int i=0 ; i<cols.count ; i++) {
            NSString *val = [cols objectAtIndex:i];
            NSString *key = nil;
            
            switch (i) {
                case 0:
                    key = [GKBConstants kCDTestID];break;
                case 1:
                    key = [GKBConstants kCDTestName];break;
                case 2:
                    key = [GKBConstants kCDTestDescription];break;
                case 3:
                    key = [GKBConstants kCDQuestion];break;
                case 4:
                    key = [GKBConstants kCDQuestionOption1];break;
                case 5:
                    key = [GKBConstants kCDQuestionOption2];break;
                case 6:
                    key = [GKBConstants kCDQuestionOption3];break;
                case 7:
                    key = [GKBConstants kCDQuestionOption4];break;
                case 8:
                    key = [GKBConstants kCDQuestionCorrectAnswer];break;
                case 9:
                    key = [GKBConstants kCDQuestionHint];break;
                case 10:
                    key = [GKBConstants kCDQuestionID];break;
                default:
                    break;
            }
            
            if (key != nil ) {
                [dict setValue:val forKey:key];
            }
            else {
                //                NSLog(@"Error creating product dictionaries: { '%@' : '%@' }", key, val);
            }
        }
        if(![[dict valueForKey:[GKBConstants kCDTestID]] isEqualToString:@""])
            [arr addObject:dict];
    }
    
    return [NSArray arrayWithArray:arr];
}

/**
 This method parsers the str passed into arrays containing dictionaries.
 
 @param str - string which needs to be parsed
 
 @return NSArray - array containing all data in a formated manner
 */
- (NSArray *)parseIntoRowsCols:(NSString *)str
{
    NSMutableArray *arr = [NSMutableArray array];
    
    char lf = 0x000A;   // LF - Line Feed
    char vt = 0x000B;   // VT - Vertical Tab
    char ff = 0x000C;   // FF - Form Feed
    char cr = 0x000D;   // CC - Carriage Return
    char nel = 0x0085;  // NEL - Next line
    char q = '"';       // Quote (")
    char com = ',';     // Comma
    
    BOOL insideQuotes = NO;
    NSInteger lastNewline = 0;
    for (int i=0 ; i<str.length ; i++) {
        unichar c = [str characterAtIndex:i];
        
        if (c == q) {
            if (i == 0) {
                insideQuotes = YES;
            }
            else if ([str characterAtIndex:i-1] == com) {
                insideQuotes = YES;
            }
            else if (i == str.length-1) {
                insideQuotes = NO;
            }
            else if ([str characterAtIndex:i+1] == com) {
                insideQuotes = NO;
            }
        }
        
        if (!insideQuotes) {
            if (c == lf || c == vt || c == ff || c == cr || c == nel ||
                i == str.length-1) {
                
                int nlOffset = 0;
                if (i == str.length-1) {
                    nlOffset = 1;
                }
                
                NSString *rowStr = [str substringWithRange:NSMakeRange(lastNewline, i-(lastNewline-nlOffset))];
//                NSLog(@"%@", rowStr);
                
                NSMutableArray *cols = [NSMutableArray array];
                int lastComma = 0;
                for (int j=0 ; j<rowStr.length ; j++) {
                    c = [rowStr characterAtIndex:j];
//                    printf("%c", c);
                    
                    if (c == q) {
                        if (j == 0) {
                            insideQuotes = YES;
                        }
                        else if ([rowStr characterAtIndex:j-1] == com) {
                            insideQuotes = YES;
                        }
                        else if (j == rowStr.length-1) {
                            insideQuotes = NO;
                        }
                        else if ([rowStr characterAtIndex:j+1] == com) {
                            insideQuotes = NO;
                        }
                    }

                    if (!insideQuotes) {
                        if (c == com || j == rowStr.length-1) {
                            
                            int endOffset = 0;
                            if (j == rowStr.length-1) {
                                endOffset = 1;
                            }
                            
                            NSString *col = [rowStr substringWithRange:NSMakeRange(lastComma, j-(lastComma-endOffset))];
//                            printf("\nNEW COLUMN: '%s'\n", [col cStringUsingEncoding:NSISOLatin1StringEncoding]);
                            
                            if (col.length > 0) {
                                NSRange firstChar = NSMakeRange(0, 1);
                                NSRange lastChar = NSMakeRange(col.length-1, 1);
                                
                                if ([col rangeOfString:@"\"" options:0 range:firstChar].location != NSNotFound &&
                                    [col rangeOfString:@"\"" options:0 range:lastChar].location != NSNotFound) {
                                    
                                    col = [col stringByReplacingCharactersInRange:firstChar withString:@""];
                                    col = [col stringByReplacingCharactersInRange:NSMakeRange(col.length-1, 1) withString:@""];
                                }
								
								// Remove any double quotations added by Excel (ex. '""')
								NSRange dqRange = [col rangeOfString:@"\"\""];
								while (dqRange.location != NSNotFound) {
									col = [col stringByReplacingCharactersInRange:NSMakeRange(dqRange.location, 1) withString:@""];
									dqRange = [col rangeOfString:@"\"\""];
								}
                            }

                            [cols addObject:col];
                            lastComma = j+1;
//                            if(cols.count == 11)
//                                break;
                        }
                    }
                }
                
                [arr addObject:cols];
                lastNewline = i+1;
                insideQuotes = NO;
            }
        }
    }
    
    return [NSArray arrayWithArray:arr];
}

@end
