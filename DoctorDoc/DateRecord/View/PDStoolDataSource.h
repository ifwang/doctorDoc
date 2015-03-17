//
//  PDStoolDataSource.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/16.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableDataSource.h"
#import "StoolVO.h"

typedef NS_ENUM(NSUInteger, PDStoolRowType)
{
    PDStoolRowTypeTimes,
    PDStoolRowTypeColor,
};

@interface PDStoolDataSource : PDTableDataSource

@property (nonatomic, strong) StoolVO *stoolVO;

@end
