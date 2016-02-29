//
//  GKBTest+CoreDataProperties.h
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GKBTest.h"

NS_ASSUME_NONNULL_BEGIN

@interface GKBTest (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *testDescription;
@property (nullable, nonatomic, retain) NSNumber *testID;
@property (nullable, nonatomic, retain) NSString *testName;
@property (nullable, nonatomic, retain) NSSet<GKBQuestion *> *questions;

@end

@interface GKBTest (CoreDataGeneratedAccessors)

- (void)addQuestionsObject:(GKBQuestion *)value;
- (void)removeQuestionsObject:(GKBQuestion *)value;
- (void)addQuestions:(NSSet<GKBQuestion *> *)values;
- (void)removeQuestions:(NSSet<GKBQuestion *> *)values;

@end

NS_ASSUME_NONNULL_END
