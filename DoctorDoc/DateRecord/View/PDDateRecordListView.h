//
//  PDDateRecordListView.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/10.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDView.h"

@protocol PDDateRecordListViewDelegate;

@interface PDDateRecordListView : PDView

@property (nonatomic, weak) id<PDDateRecordListViewDelegate> delegate;

- (void)setDateRecordList:(NSMutableArray*)drList;

- (void)addDateRecord:(NSDictionary*)drDict;

@end

@protocol PDDateRecordListViewDelegate

- (void)onDateRecordCellSelected:(NSUInteger)row;

- (void)onDeleteDateRecord:(NSUInteger)row;

@end
