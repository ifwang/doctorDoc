//
//  InspectVO.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "InspectVO.h"

@implementation InspectVO

- (id)initWithDictionary:(NSDictionary *)ditionary
{
    if (self = [super initWithDictionary:ditionary])
    {
        self.MR = [ditionary[@"MR"] boolValue];
        self.ultrasound = [ditionary[@"ultrasound"] boolValue];
        self.chest = [ditionary[@"chest"] boolValue];
    }
    
    return self;
}

- (NSDictionary*)dictionary
{
    return @{
                @"MR":@(self.MR),
                @"ultrasound":@(self.ultrasound),
                @"chest":@(self.chest),
             };
}


+(instancetype)mockVO
{
    InspectVO *inspect = [[InspectVO alloc] init];
    
    inspect.MR = YES;
    inspect.ultrasound = NO;
    inspect.chest = YES;
    
    
    return inspect;
}


@end
