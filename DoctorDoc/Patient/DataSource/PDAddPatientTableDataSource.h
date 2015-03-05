//
//  PDAddPatientTableDataSource.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableDataSource.h"
#import "PatientRecord.h"

@interface PDAddPatientTableDataSource : PDTableDataSource
/**
 *  添加病人VO
 */
@property (nonatomic, strong) PatientRecord *pRecord;

@end
