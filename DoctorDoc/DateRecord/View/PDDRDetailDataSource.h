//
//  PDDRDetailDataSource.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableDataSource.h"
#import "DateRecordVO.h"

@interface PDDRDetailDataSource : PDTableDataSource

@property (nonatomic, strong) DateRecordVO *dRecord;

@end
