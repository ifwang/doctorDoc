//
//  FeedRecordVO.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "FeedRecordVO.h"

@implementation FeedRecordVO

- (id)initWithResultSet:(FMResultSet *)result
{
    if (self = [super initWithResultSet:result])
    {
        self.selfSuck = [result boolForColumn:@"feed_selfSuck"];
        self.noseFeed = [result boolForColumn:@"feed_noseFeed"];
        self.famulaMilk = [result boolForColumn:@"feed_famulaMilk"];
        self.waterMilk = [result boolForColumn:@"feed_waterMilk"];
        self.noSugarMilk = [result boolForColumn:@"feed_noSugarMilk"];
        self.earlyBabyMilk = [result boolForColumn:@"feed_earlyBabyMilk"];
        self.vomit = [result boolForColumn:@"feed_vomit"];
        self.totleValue = [result stringForColumn:@"feed_totleValue"];
        self.perVlaue = [result stringForColumn:@"feed_perVlaue"];
    }
    
    return self;
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
    
    return feed;
    
}



@end
