//
//  FeedRecordVO.h
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"

static const NSUInteger kFeedWayNum = 2;
static const NSUInteger kMilkType = 4;

@interface FeedRecordVO : PDObject
/**
 *  喂食方法 1.鼻饲 2.自吮
 */
@property (nonatomic, copy) NSString *feedWay;
/**
 *  牛奶类型 1.配方奶 2.水解奶 3.不含乳糖奶 4.早产儿奶
 */
@property (nonatomic, copy) NSString *milkType;
/**
 *  呕吐
 */
@property (nonatomic, assign) BOOL vomit;
/**
 *  总数值 xxx ML
 */
@property (nonatomic, copy) NSString *totleValue;
/**
 *  每次数值1 xxx ML - xxx ML
 */
@property (nonatomic, copy) NSString *perVlaue1;
/**
 *  每次数值2 xxx ML - xxx ML
 */
@property (nonatomic, copy) NSString *perVlaue2;

- (NSString*)feedDescString;
+ (NSString*)feedTypeAtIndex:(NSUInteger)index;
+ (NSString*)milkTypeAtIndex:(NSUInteger)index;
+ (NSArray*)feedTypeList;
+ (NSArray*)milkTypeList;




@end
