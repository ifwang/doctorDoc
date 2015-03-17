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
        self.stoolColor = ditionary[@"stoolColor"];
    }
    
    return self;
}

- (NSDictionary*)dictionary
{
    return @{
                @"times":@(self.times),
                @"stoolColor":[self stringNotNull:_stoolColor],
             };
    
    
}

+(instancetype)mockVO
{
    StoolVO *stool = [[StoolVO alloc] init];
    
    stool.times = 3;
    stool.stoolColor = @"黄色";
    
    return stool;
}

+ (NSArray*)stoolColorList
{
    return @[@"黄色",@"绿色",@"墨绿"];
}

- (NSString*)descString
{
    NSMutableString *re = [[NSMutableString alloc] init];
    
    [re appendFormat:@"大便 %ld 次", _times ];
    
    if (_stoolColor.length > 0)
    {
        [re appendFormat:@"， %@", _stoolColor];
    }
    
    return [NSString stringWithString:re];
}

@end
