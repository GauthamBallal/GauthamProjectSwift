//
//  GKBQuestion+CoreDataProperties.h
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GKBQuestion.h"

NS_ASSUME_NONNULL_BEGIN

@interface GKBQuestion (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *correctAnswer;
@property (nullable, nonatomic, retain) NSString *hint;
@property (nullable, nonatomic, retain) NSString *optionFour;
@property (nullable, nonatomic, retain) NSString *optionOne;
@property (nullable, nonatomic, retain) NSString *optionThree;
@property (nullable, nonatomic, retain) NSString *optionTwo;
@property (nullable, nonatomic, retain) NSString *question;
@property (nullable, nonatomic, retain) NSNumber *questionID;
@property (nullable, nonatomic, retain) NSString *testDescription;
@property (nullable, nonatomic, retain) NSNumber *testID;
@property (nullable, nonatomic, retain) NSString *testName;
@property (nullable, nonatomic, retain) GKBTest *test;

@end

NS_ASSUME_NONNULL_END
