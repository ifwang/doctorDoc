//
//  FeedRecordVO.h
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"

@interface FeedRecordVO : PDObject
/**
 *  自吮
 */
@property (nonatomic, assign) BOOL selfSuck;
/**
 *  鼻饲
 */
@property (nonatomic, assign) BOOL noseFeed;
/**
 *  配方奶
 */
@property (nonatomic, assign) BOOL famulaMilk;
/**
 *  水解奶
 */
@property (nonatomic, assign) BOOL waterMilk;
/**
 *  不含乳糖奶
 */
@property (nonatomic, assign) BOOL noSugarMilk;
/**
 *  早产儿奶
 */
@property (nonatomic, assign) BOOL earlyBabyMilk;
/**
 *  呕吐
 */
@property (nonatomic, assign) BOOL vomit;
/**
 *  总数值 xxx ML
 */
@property (nonatomic, copy) NSString *totleValue;
/**
 *  每次数值 xxx ML - xxx ML
 */
@property (nonatomic, copy) NSString *perVlaue;
/**
 *  其他事项
 */
@property (nonatomic, copy) NSString *otherText;

@end
