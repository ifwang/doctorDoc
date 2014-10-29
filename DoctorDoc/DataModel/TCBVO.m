//
//  TCBVO.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "TCBVO.h"

@implementation TCBVO

- (id)initWithResultSet:(FMResultSet *)result
{
    if (self = [super initWithResultSet:result])
    {
        self.value1 = [result stringForColumn:@"tcb_value1"];
        self.value2 = [result stringForColumn:@"tcb_value2"];
        self.value3 = [result stringForColumn:@"tcb_value3"];
    }
    
    return self;
}

+(instancetype)mockVO
{
    TCBVO *tcb = [[TCBVO alloc] init];
    
    tcb.value1 = @"111";
    
    tcb.value2 = @"222";
    
    tcb.value3 = @"333";
    
    return tcb;
    
}


@end
