//
//  PatientRecord.h
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"
#import "DateRecordVO.h"
@interface PatientRecord : PDObject
/**
 *  病人编号
 */
@property (nonatomic, assign) NSUInteger pid;
/**
 *  诊断
 */
@property (nonatomic, copy) NSString *diagnostic;
/**
 *  体重 0.0-10 kg
 */
@property (nonatomic, copy) NSString *weight;
/**
 *  头围 20-60 cm
 */
@property (nonatomic, copy) NSString *headRound;
/**
 *  身长 30-70 cm 
 */
@property (nonatomic, copy) NSString *bodyLength;
/**
 *  光疗
 */
@property (nonatomic, strong) NSString *phototherapy;
/**
 *  低温
 */
@property (nonatomic, strong) NSString *hypothermia;
/**
 *  新生儿筛查
 */
@property (nonatomic, strong) NSString *newbornCheck;

@end
