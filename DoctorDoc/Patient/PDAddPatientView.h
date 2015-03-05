//
//  PDAddPatientView.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/2.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDView.h"
#import "PDAddPatientTableDataSource.h"

@protocol PDAddPatientViewDelegate

- (void)onTextCellSelected;

@end

@interface PDAddPatientView : PDView

@property (nonatomic, weak) id<PDAddPatientViewDelegate> delegate;

@property (nonatomic, strong) PDAddPatientTableDataSource *datasource;

- (void)reload;

@end
