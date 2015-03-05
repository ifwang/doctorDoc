//
//  HealRecordVO.h
//  DoctorDoc
//  医疗记录文本信息
//  Created by ifwang on 15/2/7.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDObject.h"

@interface HealRecordVO : PDObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSDate *date;

@end
