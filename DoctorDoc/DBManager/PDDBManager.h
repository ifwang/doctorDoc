//
//  PDDBManager.h
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AntibioticsVO.h"
#import "PatientRecord.h"
#import "healRecordVO.h"


@interface PDDBManager : NSObject

+ (PDDBManager*)shareInstance;
- (NSError*)lastError;
- (NSUInteger)lastIncrementID;


- (BOOL)start;
- (BOOL)deletePid:(NSUInteger)pid;

#pragma mark - Patient
- (BOOL)insertPatientVO:(PatientRecord*)record;
- (PatientRecord*)queryPatientVO:(NSUInteger)pid;
- (BOOL)updatePatientVO:(PatientRecord*)record;

#pragma mark - DailyRecord
- (BOOL)insertDailyRecord:(DateRecordVO*)record pid:(NSUInteger)pid;




@end
