//
//  PDCommon.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/7.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDCommon : NSObject

+ (NSDate*)dateFromString:(NSString*)dateStr;

+ (NSString*)stringFromDate:(NSDate*)dateStr;

+ (NSString*)dateRecordKeyWithPid:(NSString*)pid drid:(NSString*)drid;

+ (NSArray*)doubleStringListWithString:(NSString*)str;

+ (NSString*)stringWithValue1:(NSString*)value1 value2:(NSString*)value2;

@end
