//
//  PDDateRecordDetailView.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDView.h"
@class DateRecordVO;
@interface PDDateRecordDetailView : PDView

@property (nonatomic, copy) NSString *drKey;

@property (nonatomic, strong) DateRecordVO *dRecord;

- (void)reload;

@end
