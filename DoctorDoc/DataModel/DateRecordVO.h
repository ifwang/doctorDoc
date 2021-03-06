//
//  DateRecordVO.h
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"
#import "BSugarVO.h"
#import "FeedRecordVO.h"
#import "StoolVO.h"
#import "TCBVO.h"
#import "InspectVO.h"


@interface DateRecordVO : PDObject
/**
 *  记录ID
 */
@property (nonatomic, copy) NSString *drid;
/**
 *  记录日期
 */
@property (nonatomic, copy) NSDate *recordDate;
/**
 *  辐射台
 */
@property (nonatomic, assign) BOOL radio;
/**
 *  温箱
 */
@property (nonatomic, assign) BOOL warnBox;
/**
 *  温床
 */
@property (nonatomic, assign) BOOL hotBed;
/**
 *  心率1 60-250 次/分
 */
@property (nonatomic, copy) NSString *heartRate1;
/**
 *  心率2 60-250 次/分
 */
@property (nonatomic, copy) NSString *heartRate2;
/**
 *  体温1 34.0-44.0 ℃
 */
@property (nonatomic, copy) NSString *bodyTemperature1;
/**
 *  体温2 34.0-44.0 ℃
 */
@property (nonatomic, copy) NSString *bodyTemperature2;
/**
 *  呼吸1 10- 100 次/分
 */
@property (nonatomic, copy) NSString *breath1;
/**
 *  呼吸2 10- 100 次/分
 */
@property (nonatomic, copy) NSString *breath2;
/**
 *  低流量吸氧
 */
@property (nonatomic, assign) BOOL lowFlowOxy;
/**
 *  血氧 60-100 %
 */
@property (nonatomic, copy) NSString *bloodOxy1;
/**
 *  血氧 60-100 %
 */
@property (nonatomic, copy) NSString *bloodOxy2;
/**
 *  尿总
 */
@property (nonatomic, copy) NSString *urine;
/**
 *  血糖（列表形式）
 */
@property (nonatomic, strong) NSMutableArray *sugarList;
/**
 *  喂养
 */
@property (nonatomic, strong) FeedRecordVO *feed;

/**
 *  大便
 */
@property (nonatomic, strong) StoolVO *stool;
/**
 *  送检
 */
@property (nonatomic, strong) InspectVO *inspect;
/**
 *  TCB
 */
@property (nonatomic, strong) TCBVO *tcb;
/**
 *  备注
 */
@property (nonatomic, copy) NSString *other;

- (NSString*)heartRateString;
- (NSString*)bodyTemperatureString;
- (NSString*)breathString;
- (NSString*)bloodOxyString;

- (void)coverBaseInfoByDateRecord:(DateRecordVO*)dateRecord;

@end
