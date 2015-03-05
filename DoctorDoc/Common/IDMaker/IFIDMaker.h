//
//  IFIDMaker.h
//  HabbitCount
//
//  Created by ifwang on 15/1/31.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFIDMaker : NSObject

+ (IFIDMaker*)shareInstance;

- (NSUInteger)getIncrementIDWithKey:(NSString*)key;

- (BOOL)resetIDWithKey:(NSString*)key;

@end
