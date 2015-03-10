//
//  BSugarVO.m
//  DoctorDoc
//  血糖记录
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "BSugarVO.h"

@implementation BSugarVO

+ (instancetype)mockVO
{
    BSugarVO *sugarVO = [[BSugarVO alloc] init];
    sugarVO.date = [NSDate date];
    sugarVO.text = @"110.22";
    
    return sugarVO;
}



@end
