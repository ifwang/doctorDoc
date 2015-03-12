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
        
        self.heartRate1 = [self stringNotNull:ditionary[@"heartRate1"]];
        self.heartRate2 = [self stringNotNull:ditionary[@"heartRate2"]];
        self.bodyTemperature1 = [self stringNotNull:ditionary[@"bodyTemperature1"]];
        self.bodyTemperature2 = [self stringNotNull:ditionary[@"bodyTemperature2"]];
        self.breath1 = [self stringNotNull:ditionary[@"breath1"]];
        self.breath2 = [self stringNotNull:ditionary[@"breath2"]];

        
        self.lowFlowOxy = [ditionary[@"lowFlowOxy"] boolValue];
        self.bloodOxy1 = [self stringNotNull:ditionary[@"bloodOxy1"]];
        self.bloodOxy2 = [self stringNotNull:ditionary[@"bloodOxy2"]];

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
                                        @"heartRate1":[self stringNotNull:_heartRate1],
                                        @"heartRate2":[self stringNotNull:_heartRate2],
                                        @"bodyTemperature1":[self stringNotNull:_bodyTemperature1],
                                        @"bodyTemperature2":[self stringNotNull:_bodyTemperature2],
                                        @"breath1":[self stringNotNull:_breath1],
                                        @"breath2":[self stringNotNull:_breath2],
                                        @"bloodOxy1":[self stringNotNull:_bloodOxy1],
                                        @"bloodOxy2":[self stringNotNull:_bloodOxy2],
                                        @"urine":[self stringNotNull:_urine],

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
//    record.heartRate = @"60-250";
//    record.bodyTemperature = @"34.0-44.0";
//    record.breath = @"10-100";
    record.lowFlowOxy = YES;
//    record.bloodOxy = @"77-88";
    record.feed = [FeedRecordVO mockVO];
    record.urine = @"65";
    record.stool = [StoolVO mockVO];
    record.inspect = [InspectVO mockVO];
    record.tcb = [TCBVO mockVO];
    
    return record;
}

- (NSString*)heartRateString
{
    return [PDCommon stringWithValue1:_heartRate1 value2:_heartRate2];
    
    
}
- (NSString*)bodyTemperatureString
{
    return [PDCommon stringWithValue1:_bodyTemperature1 value2:_bodyTemperature2];
}
- (NSString*)breathString
{
    return [PDCommon stringWithValue1:_breath1 value2:_breath2];
}
- (NSString*)bloodOxyString
{
    return [PDCommon stringWithValue1:_bloodOxy1 value2:_bloodOxy2];
}

- (void)coverBaseInfoByDateRecord:(DateRecordVO*)dateRecord
{
    self.radio = dateRecord.radio;
    self.warnBox = dateRecord.warnBox;
    self.hotBed = dateRecord.hotBed;
    self.heartRate1 = dateRecord.heartRate1;
    self.heartRate2 = dateRecord.heartRate2;
    self.bodyTemperature1 = dateRecord.bodyTemperature1;
    self.bodyTemperature2 = dateRecord.bodyTemperature2;
    self.breath1 = dateRecord.breath1;
    self.breath2 = dateRecord.breath2;
    self.lowFlowOxy = dateRecord.lowFlowOxy;
    self.bloodOxy1 = dateRecord.bloodOxy1;
    self.bloodOxy2 = dateRecord.bloodOxy2;
}

@end
