//
//  ViewController.swift
//  GKBDataSourceManager
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

#import "GKBDataSourceManager.h"
#import "GKBCoreData.h"
#import <CoreData/CoreData.h>
#import "GKBTest.h"

@implementation GKBDataSourceManager

static GKBDataSourceManager *sharedObject = nil;

+(id)sharedGKBDataSourceManager
{
    if(!sharedObject)
    {
        sharedObject = [[GKBDataSourceManager alloc]init];
    }
    return sharedObject;
}

-(NSArray*)getAllTests
{
    NSError *error;
    NSManagedObjectContext *context = [[GKBCoreData sharedCoreDataObject] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"GKBTest" inManagedObjectContext: context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSArray *objects = [context executeFetchRequest:request error:&error];
    NSMutableArray *mutableCopy = [[NSMutableArray alloc] initWithArray:objects];
    [mutableCopy sortUsingComparator:^NSComparisonResult(GKBTest *obj1, GKBTest *obj2) {
        return [obj1.testID intValue] > [obj2.testID intValue];
    }];
    
    return [NSArray arrayWithArray:mutableCopy];
}

@end
