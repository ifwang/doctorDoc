//
//  PDObject.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"
#import <objc/runtime.h>
@implementation PDObject

- (NSString*)description
{
    int i;
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    
    NSMutableString *descirption = [[NSMutableString alloc] init];
    
    [descirption appendFormat:@"%@:{\n",NSStringFromClass([self class])];
    
    for ( i=0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = propertyList + i;
        const char* propertyName = property_getName(*thisProperty);
        
        NSString *pro = [NSString stringWithUTF8String:propertyName];
        
        id propertyValue = [self valueForKey:pro];
        
        [descirption appendFormat:@"%@ : %@\n",pro,propertyValue];
        
    }
    
    [descirption appendString:@"\n}"];
    
    
    return descirption;
}

+ (instancetype)mockVO
{
    return [[PDObject alloc] init];
}

- (instancetype)initWithResultSet:(FMResultSet*)result
{
    return [self init];
}


@end
