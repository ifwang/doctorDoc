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
 *  黄色
 */
@property (nonatomic, assign) BOOL isYellow;
/**
 *  绿色
 */
@property (nonatomic, assign) BOOL isGreen;
/**
 *  墨绿色
 */
@property (nonatomic, assign) BOOL isDarkGreen;
/**
 *  其他备注
 */
@property (nonatomic, copy) NSString *other;

@end
