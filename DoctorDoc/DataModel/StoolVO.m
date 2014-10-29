//
//  StoolVO.m
//  DoctorDoc
//  大便记录
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "StoolVO.h"

@implementation StoolVO

- (id)initWithResultSet:(FMResultSet *)result
{
    if (self = [super initWithResultSet:result])
    {
        self.times = [result intForColumn:@"stool_times"];
        self.isYellow = [result boolForColumn:@"stool_isYellow"];
        self.isGreen = [result boolForColumn:@"stool_isGreen"];
        self.isDarkGreen = [result boolForColumn:@"stool_isDarkGreen"];
        self.other = [result stringForColumn:@"other"];
    }
    
    return self;
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
