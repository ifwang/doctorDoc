//
//  PDAddPatientViewController.h
//  DoctorDoc
//  添加病人VC
//  Created by ifwang on 15/3/2.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
#import "PatientRecord.h"

@protocol PDAddPatientViewControllerDelegate

- (void)onPatientInfoFinished:(PatientRecord*)patientRecord;

@end

@interface PDAddPatientViewController : PDViewController

@property (nonatomic, assign) PDAddVCSourceType souceType;

@property (nonatomic, weak) id<PDAddPatientViewControllerDelegate> delegate;

- (void)setPatientRecord:(PatientRecord*)patientRecord;

@end
