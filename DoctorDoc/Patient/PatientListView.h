//
//  PatientListView.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDView.h"

@protocol PatientListViewDelegate

- (void)onDeleteCellAtRow:(NSInteger)row;

- (void)onSelectCellAtRow:(NSInteger)row;

@end

@interface PatientListView : PDView

@property (nonatomic, weak) id<PatientListViewDelegate> delegate;

- (void)setPatients:(NSArray*)pList;

- (void)addPatient:(NSDictionary*)pDict;

- (void)deleteIdexPath:(NSIndexPath*)indexPath;

@end
