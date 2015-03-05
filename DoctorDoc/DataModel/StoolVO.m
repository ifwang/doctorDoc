//
//  StoolVO.m
//  DoctorDoc
//  大便记录
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "StoolVO.h"

@implementation StoolVO

- (id)initWithDictionary:(NSDictionary *)ditionary
{
    if (self = [super initWithDictionary:(NSDictionary *)ditionary])
    {
        self.times = [ditionary[@"times"] integerValue];
        self.isYellow = [ditionary[@"isYellow"] boolValue];
        self.isGreen = [ditionary[@"isGreen"] boolValue];
        self.isDarkGreen = [ditionary[@"isDarkGreen"] boolValue];
        self.other = [self stringNotNull:ditionary[@"isYellow"]];
    }
    
    return self;
}

- (NSDictionary*)dictionary
{
    return @{
                @"times":@(self.times),
                @"isYellow":@(self.isYellow),
                @"isGreen":@(self.isGreen),
                @"isDarkGreen":@(self.isDarkGreen),
                @"other":[self stringNotNull:_other]
             };
    
    
}

+(instancetype)mockVO
{
    StoolVO *stool = [[StoolVO alloc] init];
    
    stool.times = 3;
    stool.isYellow =YES;
    stool.isGreen = YES;
    stool.isDarkGreen = NO;
    stool.other = @"屎黄色";
    
    return stool;
}


@end
