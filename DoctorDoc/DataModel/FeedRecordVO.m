//
//  FeedRecordVO.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "FeedRecordVO.h"

@implementation FeedRecordVO

- (id)initWithDictionary:(NSDictionary *)ditionary
{
    if (self = [super initWithDictionary:ditionary])
    {
        self.selfSuck = [ditionary[@"selfSuck"] boolValue];
        self.noseFeed = [ditionary[@"noseFeed"] boolValue];
        self.famulaMilk = [ditionary[@"famulaMilk"] boolValue];
        self.waterMilk = [ditionary[@"waterMilk"] boolValue];
        self.noSugarMilk = [ditionary[@"noSugarMilk"] boolValue];
        self.earlyBabyMilk = [ditionary[@"earlyBabyMilk"] boolValue];
        self.vomit = [ditionary[@"vomit"] boolValue];
        
        self.totleValue = [self stringNotNull:ditionary[@"totleValue"]];
        self.perVlaue = [self stringNotNull:ditionary[@"perVlaue"]];
        self.otherText = [self stringNotNull:ditionary[@"otherText"]];
    }
    
    return self;
}

- (NSDictionary*)dictionary
{
    return @{
                @"selfSuck":@(self.selfSuck),
                @"noseFeed":@(self.noseFeed),
                @"famulaMilk":@(self.famulaMilk),
                @"waterMilk":@(self.waterMilk),
                @"noSugarMilk":@(self.noSugarMilk),
                @"earlyBabyMilk":@(self.earlyBabyMilk),
                @"vomit":@(self.vomit),
                @"totleValue":[self stringNotNull:_totleValue],
                @"perVlaue":[self stringNotNull:_perVlaue],
                @"otherText":[self stringNotNull:_otherText]
             };
    
    
}


+(instancetype)mockVO
{
    FeedRecordVO *feed = [[FeedRecordVO alloc] init];
    
    feed.selfSuck = YES;
    feed.noseFeed = NO;
    feed.famulaMilk = YES;
    feed.waterMilk = YES;
    feed.noSugarMilk = NO;
    feed.earlyBabyMilk = YES;
    feed.vomit = YES;
    feed.totleValue = @"879";
    feed.perVlaue = @"876-233";
    feed.otherText = @"备注备注";
    return feed;
    
}



@end
