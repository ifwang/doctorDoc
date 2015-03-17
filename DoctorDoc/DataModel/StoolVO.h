//
//  StoolVO.h
//  DoctorDoc
//  大便记录
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"

@interface StoolVO : PDObject
/**
 *  大便次数 1 - 10
 */
@property (nonatomic, assign) NSUInteger times;
/**
 *  大便颜色
 */
@property (nonatomic, copy) NSString *stoolColor;


+ (NSArray*)stoolColorList;

@end
