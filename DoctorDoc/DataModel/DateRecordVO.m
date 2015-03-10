//
//  DateRecordVO.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "DateRecordVO.h"

@implementation DateRecordVO

- (id)initWithDictionary:(NSDictionary *)ditionary
{
    if (self = [super initWithDictionary:ditionary])
    {
        self.drid =  [self stringNotNull:ditionary[@"drid"]];
        self.recordDate = [PDCommon dateFromString:ditionary[@"recordDate"]];
        self.radio = [ditionary[@"radio"] boolValue];
        self.warnBox = [ditionary[@"warnBox"] boolValue];
        self.hotBed = [ditionary[@"hotBed"] boolValue];
        
        self.heartRate = [self stringNotNull:ditionary[@"heartRate"]];
        self.bodyTemperature = [self stringNotNull:ditionary[@"bodyTemperature"]];
        self.breath = [self stringNotNull:ditionary[@"breath"]];
        
        
        self.lowFlowOxy = [ditionary[@"lowFlowOxy"] boolValue];
        self.bloodOxy = [self stringNotNull:ditionary[@"bloodOxy"]];
        self.urine = [self stringNotNull:ditionary[@"urine"]];

        self.feed = [[FeedRecordVO alloc] initWithDictionary:ditionary[@"feed"]];
        self.stool = [[StoolVO alloc] initWithDictionary:ditionary[@"stool"]];
        self.inspect = [[InspectVO alloc] initWithDictionary:ditionary[@"inspect"]];
        self.tcb = [[TCBVO alloc] initWithDictionary:ditionary[@"tcb"]];
        
        NSArray *tSugarDictList = ditionary[@"sugarList"];
        NSMutableArray *tList = [[NSMutableArray alloc] init];
            
        [tSugarDictList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *dict = obj;
                
                [tList addObject:[[BSugarVO alloc] initWithDictionary:dict]];
            }];
        self.sugarList = tList;
    }
    
    return self;
}

- (NSDictionary*)dictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict addEntriesFromDictionary:@{
                                        @"drid":[self stringNotNull:self.drid],
                                        @"radio":@(self.radio),
                                        @"warnBox":@(self.warnBox),
                                        @"hotBed":@(self.hotBed),
                                        @"lowFlowOxy":@(self.lowFlowOxy),
                                        @"recordDate":[PDCommon stringFromDate:_recordDate],
                                        @"heartRate":[self stringNotNull:@"heartRate"],
                                        @"bodyTemperature":[self stringNotNull:@"bodyTemperature"],
                                        @"breath":[self stringNotNull:@"breath"],
                                        @"bloodOxy":[self stringNotNull:@"bloodOxy"],
                                        @"urine":[self stringNotNull:@"urine"],

                                        }];
    

    NSMutableArray *tList = [[NSMutableArray alloc] init];
    [_sugarList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BSugarVO *sugar = obj;
        [tList addObject:[sugar dictionary]];
        
    }];
    
    [dict setObject:tList forKey:@"sugarList"];
    
    
    
    if (_feed != nil)
    {
        [dict setObject:[_feed dictionary] forKey:@"feed"];
    }
    
    if (_feed != nil)
    {
        [dict setObject:[_feed dictionary] forKey:@"feed"];
    }
    
    if (_stool != nil)
    {
        [dict setObject:[_feed dictionary] forKey:@"stool"];
    }
    
    if (_inspect != nil)
    {
        [dict setObject:[_feed dictionary] forKey:@"inspect"];
    }
    
    if (_tcb != nil)
    {
        [dict setObject:[_feed dictionary] forKey:@"tcb"];
    }
    
    return dict;
}


+(instancetype)mockVO
{
    DateRecordVO *record = [[DateRecordVO alloc] init];
    
    record.drid = @"3422";
    record.recordDate = [NSDate date];
    record.radio = YES;
    record.warnBox = YES;
    record.hotBed = YES;
    record.heartRate = @"60-250";
    record.bodyTemperature = @"34.0-44.0";
    record.breath = @"10-100";
    record.lowFlowOxy = YES;
    record.bloodOxy = @"77-88";
    record.feed = [FeedRecordVO mockVO];
    record.urine = @"65";
    record.stool = [StoolVO mockVO];
    record.inspect = [InspectVO mockVO];
    record.tcb = [TCBVO mockVO];
    
    return record;
}


@end
