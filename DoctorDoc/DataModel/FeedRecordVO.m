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
        self.feedWay = [self stringNotNull:ditionary[@"feedWay"]];
        self.milkType = [self stringNotNull:ditionary[@"milkType"]];
        self.vomit = [ditionary[@"vomit"] boolValue];
        
        self.totleValue = [self stringNotNull:ditionary[@"totleValue"]];
        self.perVlaue1 = [self stringNotNull:ditionary[@"perVlaue1"]];
        self.perVlaue2 = [self stringNotNull:ditionary[@"perVlaue2"]];

    }
    
    return self;
}

- (NSDictionary*)dictionary
{
    return @{
                @"milkType":[self stringNotNull:_milkType],
                @"feedWay":[self stringNotNull:_feedWay],
                @"vomit":@(self.vomit),
                @"totleValue":[self stringNotNull:_totleValue],
                @"perVlaue1":[self stringNotNull:_perVlaue1],
                @"perVlaue2":[self stringNotNull:_perVlaue2],
             };
    
    
}


+(instancetype)mockVO
{
    FeedRecordVO *feed = [[FeedRecordVO alloc] init];
    
    feed.milkType = @"配方奶";
    feed.feedWay = @"鼻饲";
    feed.vomit = YES;
    feed.totleValue = @"879";
    feed.perVlaue1 = @"876";
    feed.perVlaue2 = @"975";
    return feed;
}

+ (NSString*)feedTypeAtIndex:(NSUInteger)index
{
    
    NSArray *array = [FeedRecordVO feedTypeList];
    
    if (index >= array.count) {
        return nil;
    }
    
    return array[index];
}

+ (NSString*)milkTypeAtIndex:(NSUInteger)index
{
    
    NSArray *array = [FeedRecordVO milkTypeList];
    if (index >= array.count) {
        return nil;
    }
    
    return array[index];
}

+ (NSArray*)feedTypeList
{
    return @[@"鼻饲",@"自吮"];
}

+ (NSArray*)milkTypeList
{
    return @[@"配方奶",@"水解奶",@"不含乳糖奶",@"早产儿奶"];
}

- (NSString*)feedDescString
{
    NSMutableString *desc = [[NSMutableString alloc] init];
    
    if (_feedWay.length > 0)
    {
        [desc appendFormat:@"%@，",_feedWay];
    }
    
    if (_milkType.length > 0)
    {
        [desc appendFormat:@"%@，", _milkType];
    }
    
    if (_vomit)
    {
        [desc appendString:@"呕吐，"];
    }
    
    if (_totleValue.length > 0)
    {
        [desc appendFormat:@"总量: %@ ML，", _totleValue];
    }
    
    NSString *perValueString = [PDCommon stringWithValue1:_perVlaue1 value2:_perVlaue2];
    
    if (perValueString != nil)
    {
        [desc appendFormat:@"每次: %@ ML，", perValueString];
    }
    
    if (desc.length > 0 )
    {
        return [desc substringToIndex:desc.length-1];
    }
    
    return @"暂无数据";
    
}

@end
