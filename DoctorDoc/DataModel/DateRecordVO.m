//
//  DateRecordVO.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "DateRecordVO.h"

@implementation DateRecordVO

- (id)initWithResultSet:(FMResultSet *)result
{
    if (self = [super initWithResultSet:result])
    {
        self.drid = [result intForColumn:@"drid"];
        self.recordDate = [result dateForColumn:@"recordDate"];
        self.radio = [result boolForColumn:@"radio"];
        self.warnBox = [result boolForColumn:@"warnBox"];
        self.hotBed = [result boolForColumn:@"hotBed"];
        self.heartRate = [result stringForColumn:@"heartRate"];
        self.bodyTemperature = [result stringForColumn:@"bodyTemperature"];
        self.breath = [result stringForColumn:@"breath"];
        self.lowFlowOxy = [result boolForColumn:@"lowFlowOxy"];
        self.bloodOxy = [result stringForColumn:@"bloodOxy"];

        self.feed = [[FeedRecordVO alloc] initWithResultSet:result];
        
        self.urine = [result stringForColumn:@"urine"];
        
        self.stool = [[StoolVO alloc] initWithResultSet:result];
        self.inspect = [[InspectVO alloc] initWithResultSet:result];
        self.tcb = [[TCBVO alloc] initWithResultSet:result];
    }
    
    return self;
}

+(instancetype)mockVO
{
    DateRecordVO *record = [[DateRecordVO alloc] init];
    
    record.drid = 3422;
    record.recordDate = [NSDate date];
    record.radio = YES;
    record.warnBox = YES;
    record.hotBed = NO;
    record.heartRate = @"88";
    record.bodyTemperature = @"123";
    record.breath = @"22.1";
    record.lowFlowOxy = YES;
    record.bloodOxy = @"77";
    record.feed = [FeedRecordVO mockVO];
    record.urine = @"65";
    record.stool = [StoolVO mockVO];
    record.inspect = [InspectVO mockVO];
    record.tcb = [TCBVO mockVO];

    
    return record;
}


@end
