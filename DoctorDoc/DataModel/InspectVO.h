//
//  InspectVO.h
//  DoctorDoc
//  送检记录
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"

@interface InspectVO : PDObject
/**
 *  MR
 */
@property (nonatomic, assign) BOOL MR;
/**
 *  超声
 */
@property (nonatomic, assign) BOOL ultrasound;
/**
 *  胸片
 */
@property (nonatomic, assign) BOOL chest;

@end
