//
//  PatientRecord.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PatientRecord.h"

@implementation PatientRecord

+ (instancetype)mockVO
{
    PatientRecord *record = [[PatientRecord alloc] init];
    
    record.pid = @"3456";
    record.diagnostic = @"白仁，太残忍";
    record.weight = @"88";
    record.headRound = @"55";
    record.bodyLength = @"221";
    
    NSDate *date = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    record.hypothermia = date;
    record.newbornCheck= date;
    
    record.phototherapyList = @[date, date2];
    record.antibioticsList = @[[AntibioticsVO mockVO]];
    record.healRecordList = @[[HealRecordVO mockVO]];
    
    
    return record;
}

- (instancetype)initWithDictionary:(NSDictionary *)ditionary
{
    if(self = [super initWithDictionary:ditionary])
    {
        self.pid = [ditionary objectForKey:@"pid"];
        self.diagnostic = [ditionary objectForKey:@"diagnostic"];
        self.weight = [ditionary objectForKey:@"weight"];
        self.headRound = [ditionary objectForKey:@"headRound"];
        self.bodyLength = [ditionary objectForKey:@"bodyLength"];
        
        self.hypothermia = [PDCommon dateFromString:ditionary[@"hypothermia"]];
        self.newbornCheck = [PDCommon dateFromString:ditionary[@"newbornCheck"]];
        
        NSArray *photoStrList = ditionary[@"phototherapyList"];
        if (photoStrList != nil)
        {
            NSMutableArray *tList = [NSMutableArray array];
            for (NSString *dateStr in photoStrList)
            {
                NSDate *pdate = [PDCommon dateFromString:dateStr];
                [tList addObject:pdate];
            }
            self.phototherapyList = [NSArray arrayWithArray:tList];
        }
        
        NSArray *antiDictList = ditionary[@"antibioticsList"];
        if (antiDictList != nil)
        {
            NSMutableArray *tList = [NSMutableArray array];
            for (NSDictionary *antiDic in antiDictList)
            {
                AntibioticsVO *antiVO = [[AntibioticsVO alloc] initWithDictionary:antiDic];
                [tList addObject:antiVO];
            }
            self.antibioticsList = [NSArray arrayWithArray:tList];
        }
        
        NSArray *healDictList = ditionary[@"healRecordList"];
        if (healDictList != nil)
        {
            NSMutableArray *tList = [NSMutableArray array];
            for (NSDictionary *healDict in healDictList)
            {
                HealRecordVO *healVO = [[HealRecordVO alloc] initWithDictionary:healDict];
                [tList addObject:healVO];
            }
            self.healRecordList = [NSArray arrayWithArray:tList];
        }
    }
    
    return self;
}

- (NSDictionary*)dictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    dict[@"pid"] = [self stringNotNull:_pid];
    dict[@"diagnostic"] = [self stringNotNull:_diagnostic];
    dict[@"weight"] = [self stringNotNull:_weight];
    dict[@"headRound"] = [self stringNotNull:_headRound];
    dict[@"bodyLength"] = [self stringNotNull:_bodyLength];
    dict[@"hypothermia"] = [PDCommon stringFromDate:_hypothermia];
    dict[@"newbornCheck"] = [PDCommon stringFromDate:_newbornCheck];
    
    NSMutableArray *tList = [NSMutableArray array];
    for (NSDate *photoDate in _phototherapyList)
    {
        [tList addObject:[PDCommon stringFromDate:photoDate]];
    }
    dict[@"phototherapyList"] = tList;
    
    [tList removeAllObjects];
    for (AntibioticsVO *antiVO in _antibioticsList)
    {
        [tList addObject:[antiVO dictionary]];
    }
    dict[@"antibioticsList"] = tList;
    
    [tList removeAllObjects];
    for (HealRecordVO *healVO in _healRecordList)
    {
        [tList addObject:[healVO dictionary]];
    }
    dict[@"healRecordList"] = tList;
    
    return dict;
}


@end
