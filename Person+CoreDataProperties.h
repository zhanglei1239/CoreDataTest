//
//  Person+CoreDataProperties.h
//  CoreDataTest
//
//  Created by zhanglei on 15/10/8.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSNumber *gender;
@property (nullable, nonatomic, retain) Card *card;

@end

NS_ASSUME_NONNULL_END
