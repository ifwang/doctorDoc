//
//  TCBVO.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "TCBVO.h"

@implementation TCBVO

- (id)initWithDictionary:(NSDictionary *)ditionary
{
    if (self = [super initWithDictionary:ditionary])
    {
        self.value1 = [self stringNotNull:ditionary[@"value1"]];
        self.value2 = [self stringNotNull:ditionary[@"value2"]];
        self.value3 = [self stringNotNull:ditionary[@"value3"]];
    }
    
    return self;
}

- (NSDictionary*)dictionary
{
    return @{
                @"value1":[self stringNotNull:_value1],
                @"value2":[self stringNotNull:_value2],
                @"value3":[self stringNotNull:_value3],
             };
    
    
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
