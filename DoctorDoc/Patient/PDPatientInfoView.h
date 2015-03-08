//
//  PDPatientInfoView.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDView.h"
#import "PDPatientInfoTableDataSource.h"

@protocol PDPatientInfoViewDelegate

- (void)onBaseInfoBtnClicked;

- (void)onDialogCellClicked;

- (void)onAntiCellSelectedAtRow:(NSUInteger)row;

- (void)onDeleteAntiCellAtRow:(NSUInteger)row;

- (void)onPhotoCellSelectedAtRow:(NSUInteger)row;

- (void)onDeletePhotoCellAtRow:(NSUInteger)row;

@end

@interface PDPatientInfoView : PDView

@property (nonatomic, strong) PatientRecord *patientRecord;

@property (nonatomic, weak) id<PDPatientInfoViewDelegate> delegate;

@end
