//
//  PDCommon.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/7.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDCommon.h"

@implementation PDCommon

+(NSDate*)dateFromString:(NSString*)dateStr
{
    if (dateStr == nil || dateStr.length == 0)
    {
        return nil;
    }
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [dateFormater dateFromString:dateStr];
    
    
}

+ (NSString*)stringFromDate:(NSDate*)date
{
    if (date == nil)
    {
        return @"";
    }
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [dateFormater stringFromDate:date];
}
@end
