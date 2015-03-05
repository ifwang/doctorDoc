//
//  IFIDMaker.m
//  HabbitCount
//
//  Created by ifwang on 15/1/31.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "IFIDMaker.h"

const static NSUInteger kKeyInitValue = 10000;
static NSString *kIDMakerStorePath = @"kIDMakerStore";

@interface IFIDMaker()

@property (nonatomic, strong) NSMutableDictionary *idmakerStoreDic;

@end

@implementation IFIDMaker

+ (IFIDMaker*)shareInstance
{
    static IFIDMaker *idmaker = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        idmaker = [[IFIDMaker alloc] init];
    });
    
    return idmaker;
}

- (id)init
{
    if (self = [super init])
    {
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString* dbpath = [docsdir stringByAppendingPathComponent:kIDMakerStorePath];
        
        self.idmakerStoreDic = [NSKeyedUnarchiver unarchiveObjectWithFile:dbpath];
        if (_idmakerStoreDic == nil)
        {
            self.idmakerStoreDic = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (NSUInteger)getIncrementIDWithKey:(NSString*)key
{
    if (key == nil)
    {
        return -1;
    }
    NSUInteger incrementId;
    
    @synchronized(_idmakerStoreDic)
    {
        
        incrementId = [[_idmakerStoreDic objectForKey:key] integerValue];
        
        if (incrementId == 0)
        {
            incrementId = kKeyInitValue;
        }
        
        incrementId ++;
        
        [_idmakerStoreDic setObject:@(incrementId) forKey:key];
        
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString* dbpath = [docsdir stringByAppendingPathComponent:kIDMakerStorePath];
        
        [NSKeyedArchiver archiveRootObject:_idmakerStoreDic toFile:dbpath];

    }
    
    return incrementId;
    
}

- (BOOL)resetIDWithKey:(NSString*)key
{
    if (key == nil)
    {
        return  NO;
    }
    
    NSLog(@"try get id maker dictionary.");
    @synchronized(_idmakerStoreDic)
    {
        NSLog(@"get lock");
        
        [_idmakerStoreDic setObject:@(kKeyInitValue) forKey:key];
        
        
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString* dbpath = [docsdir stringByAppendingPathComponent:kIDMakerStorePath];
        
        [NSKeyedArchiver archiveRootObject:_idmakerStoreDic toFile:dbpath];
        
        NSLog(@"unlock");
    }
    
    return YES;
}


@end
