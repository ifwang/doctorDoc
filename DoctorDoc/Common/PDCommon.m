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

+ (NSString*)dateRecordKeyWithPid:(NSString*)pid drid:(NSString*)drid
{
    return [NSString stringWithFormat:@"%@_%@",pid,drid];
}

+ (NSArray*)doubleStringListWithString:(NSString*)str
{
    if (str==nil||str.length == 0)
    {
        return nil;
    }
    
    if ([str rangeOfString:@"-"].length > 0)
    {
        return [str componentsSeparatedByString:@"-"];
    }
    
    return nil;
}

+ (NSString*)stringWithValue1:(NSString*)value1 value2:(NSString*)value2
{
    BOOL isValue1Nil = (value1 == nil) || value1.length == 0;
    BOOL isValue2Nil = (value2 == nil) || value2.length == 0;

    
    if (isValue1Nil && isValue2Nil) {
        return nil;
    }
    
    if (isValue1Nil)
    {
        return [NSString stringWithFormat:@"%@-%@",value2,value2];
    }
    
    if (isValue2Nil) {
        return [NSString stringWithFormat:@"%@-%@",value1,value1];
    }
    
    return [NSString stringWithFormat:@"%@-%@",value1,value2];
}


@end
