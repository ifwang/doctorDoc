//
//  HealRecordVO.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/7.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "HealRecordVO.h"

@implementation HealRecordVO

+ (instancetype)mockVO
{
    HealRecordVO *antiVO = [[HealRecordVO alloc] init];
    
    antiVO.date = [NSDate dateWithTimeIntervalSince1970:1424793600];
    antiVO.text = @"记录111";
    
    
    return antiVO;
}

- (id)initWithDictionary:(NSDictionary *)ditionary
{
    if (self = [super initWithDictionary:ditionary])
    {
        self.date = [PDCommon dateFromString:ditionary[@"date"]];
        self.text = ditionary[@"text"];
    }
    
    return self;
}

- (NSDictionary*)dictionary
{
    return @{
                 @"date":[PDCommon stringFromDate:self.date],
                 @"text":[self stringNotNull:self.text]
             };
}
@end
