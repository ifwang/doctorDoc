//
//  PDDRBaseInfoDataSource.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableDataSource.h"
#import "DateRecordVO.h"

typedef NS_ENUM(NSUInteger, PDDRBaseInfoRowType)
{
    PDDRBaseInfoRowTypeRadio=0,
    PDDRBaseInfoRowTypeWarnbox,
    PDDRBaseInfoRowTypeHotBed,
    PDDRBaseInfoRowTypeBodyTem1,
    PDDRBaseInfoRowTypeBodyTem2,
    PDDRBaseInfoRowTypeHeartRate1,
    PDDRBaseInfoRowTypeHeartRate2,
    PDDRBaseInfoRowTypeBreath1,
    PDDRBaseInfoRowTypeBreath2,
    PDDRBaseInfoRowTypeLowOxy,
    PDDRBaseInfoRowTypeBloodOxy1,
    PDDRBaseInfoRowTypeBloodOxy2,
};

@interface PDDRBaseInfoDataSource : PDTableDataSource

@property (nonatomic, strong) DateRecordVO *dRecord;

@end
