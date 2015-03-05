//
//  PDObject.h
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "PDCommon.h"

@interface PDObject : NSObject

+ (instancetype)mockVO;

- (instancetype)initWithDictionary:(NSDictionary*)ditionary;

- (NSDictionary*)dictionary;

- (NSString*)stringNotNull:(NSString*)string;

@end
