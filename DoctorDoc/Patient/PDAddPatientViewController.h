//
//  PDAddPatientViewController.h
//  DoctorDoc
//  添加病人VC
//  Created by ifwang on 15/3/2.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
#import "PatientRecord.h"

typedef NS_ENUM(NSUInteger, PDAddVCSourceType)
{
    PDAddVCSourceTypeAdd = 0,
    PDAddVCSourceTypeEdit = 1
};

@interface PDAddPatientViewController : PDViewController

@property (nonatomic, assign) PDAddVCSourceType souceType;

- (void)setPatientRecord:(PatientRecord*)patientRecord;

@end
