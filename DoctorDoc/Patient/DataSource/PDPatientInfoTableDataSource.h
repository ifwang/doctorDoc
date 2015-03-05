//
//  PDPatientInfoTableDataSource.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/5.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableDataSource.h"

@interface PDPatientInfoTableDataSource : PDTableDataSource
/**
 *  病人VO
 */
@property (nonatomic, strong) PatientRecord *pRecord;

@end
