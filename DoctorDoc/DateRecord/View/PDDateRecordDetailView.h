//
//  PDDateRecordDetailView.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDView.h"
#import "PDDRDetailDataSource.h"

@class DateRecordVO;
@class PatientRecord;
@protocol PDDateRecordDetailViewDelegate;


@interface PDDateRecordDetailView : PDView

@property (nonatomic, copy) NSString *drKey;

@property (nonatomic, strong) DateRecordVO *dRecord;

@property (nonatomic, weak) id<PDDateRecordDetailViewDelegate> delegate;

- (void)reload;

- (void)setPatientRecord:(PatientRecord*)patientRecord;

@end


@protocol PDDateRecordDetailViewDelegate

- (void)onFeedCellSelected;

- (void)onUrineCellSelected;

- (void)onStoolCellSelected;

- (void)onTCBCellSelected;

- (void)onInspectCellSelected;

@end
