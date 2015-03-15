//
//  PDDateRecordDetailViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/10.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
@class PatientRecord;
@interface PDDateRecordDetailViewController : PDViewController

@property (nonatomic, copy) NSString *drKey;

@property (nonatomic, weak) PatientRecord *pRecord;

@end
