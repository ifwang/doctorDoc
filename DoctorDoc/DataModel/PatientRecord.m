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
    
    record.pid = 3456;
    record.diagnostic = @"白仁，太残忍";
    record.weight = @"88";
    record.headRound = @"55";
    record.bodyLength = @"221";
    record.phototherapy = @"8/9";
    record.hypothermia = @"8/9/12/7";
    record.newbornCheck = @"9/2";
    
    return record;
}

- (instancetype)initWithResultSet:(FMResultSet *)result
{
    if (self = [super initWithResultSet:result])
    {
        if ([result next])
        {
            self.pid = [result intForColumn:@"PID"];
            self.diagnostic = [result stringForColumn:@"diagnostic"];
            self.weight = [result stringForColumn:@"weight"];
            self.headRound = [result stringForColumn:@"headRound"];
            self.bodyLength = [result stringForColumn:@"bodyLength"];
            self.phototherapy = [result stringForColumn:@"phototherapy"];
            self.hypothermia = [result stringForColumn:@"hypothermia"];
            self.newbornCheck = [result stringForColumn:@"newbornCheck"];
            
            return self;
        }
    }
    
    return nil;
}

@end
