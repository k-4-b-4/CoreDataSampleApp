//
//  Entity.h
//  CoreDataSampleApp
//
//  Created by 川端和樹 on 2013/05/24.
//  Copyright (c) 2013年 LemonApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSDate * deadline;
@property (nonatomic, retain) NSString * homeWork;
@property (nonatomic, retain) NSNumber * isExistAssign;
@property (nonatomic, retain) NSString * labelA;
@property (nonatomic, retain) NSString * labelB;
@property (nonatomic, retain) NSNumber * tag;

@end
