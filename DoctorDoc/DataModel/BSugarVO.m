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
    sugarVO.hour = 23;
    sugarVO.min = 59;
    sugarVO.value = 110.22;
    
    return sugarVO;
}


- (id)initWithDictionary:(NSDictionary *)ditionary
{
    if (self = [super initWithDictionary:ditionary])
    {
        self.hour = [ditionary[@"hour"] integerValue];
        self.min = [ditionary[@"min"] integerValue];
        self.value = [ditionary[@"value"] doubleValue];
    }
    return self;
}

- (NSDictionary*)dictionary
{
    return @{
             @"hour":@(_hour),
             @"min":@(_min),
             @"value":@(_value)
             };
}

@end
