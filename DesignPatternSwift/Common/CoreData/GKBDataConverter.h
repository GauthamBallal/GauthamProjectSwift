//
//  ViewController.swift
//  GKBDataConverter
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 DXDataConverter contains colour data and wallpaper data. It is
 responsible for parsing products to array and parsers the str passed into arrays containing dictionaries.
 */

@interface GKBDataConverter : NSObject {
    NSString *testsData;
    NSString *questionsData;

}
@property (nonatomic, copy) NSString *colourData;
@property (nonatomic, copy) NSString *wallpaperData;

- (id)initWithTestsData:(NSString *)testsFile andQuestsionsData:(NSString*)questionsFile;
- (BOOL)exportFilesToCoreData;

- (NSArray *)parseTestsToArray:(NSString *)str;
- (NSArray *)parseIntoRowsCols:(NSString *)str;

@end
