//
//  healRecordVO.h
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"

@interface healRecordVO : PDObject

@property (nonatomic, assign) NSUInteger hid;

@property (nonatomic, strong) NSDate *recordDate;

@property (nonatomic, copy) NSString *recordText;

@end
