//
//  InspectVO.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "InspectVO.h"

@implementation InspectVO

- (id)initWithResultSet:(FMResultSet *)result
{
    if (self = [super initWithResultSet:result])
    {
        self.MR = [result boolForColumn:@"inspect_MR"];
        self.ultrasound = [result boolForColumn:@"inspect_ultrasound"];
        self.chest = [result boolForColumn:@"inspect_chest"];
    }
    
    return self;
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
