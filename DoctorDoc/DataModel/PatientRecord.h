//
//  PatientRecord.h
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDObject.h"
#import "DateRecordVO.h"
#import "AntibioticsVO.h"
#import "HealRecordVO.h"

@interface PatientRecord : PDObject
/**
 *  病人编号
 */
@property (nonatomic, copy) NSString *pid;
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
 *  低温日期
 */
@property (nonatomic, strong) NSDate *hypothermia;
/**
 *  新生儿筛查日期
 */
@property (nonatomic, strong) NSDate *newbornCheck;

/**
 *  光疗记录
 */
@property (nonatomic, strong) NSArray *phototherapyList;
/**
 *  抗生素记录
 */
@property (nonatomic, strong) NSArray *antibioticsList;
/**
 *  治疗文本记录
 */
@property (nonatomic,strong) NSArray *healRecordList;

@end
