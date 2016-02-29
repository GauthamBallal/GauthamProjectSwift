//
//  ViewController.swift
//  GKBDataSourceManager
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKBDataSourceManager : NSObject
+ (GKBDataSourceManager*)sharedGKBDataSourceManager;

-(NSArray*)getAllTests;
@end
