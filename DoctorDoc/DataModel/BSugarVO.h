//
//  BSugarVO.h
//  DoctorDoc
//  血糖记录
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"

@interface BSugarVO : PDObject
/**
 *  时
 */
@property (nonatomic, assign) NSUInteger hour;
/**
 *  分
 */
@property (nonatomic, assign) NSUInteger min;
/**
 *  用量
 */
@property (nonatomic, assign) double value;

@end
