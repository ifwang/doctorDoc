//
//  PDDRBaseInfoViewController.h
//  DoctorDoc
//  每日记录基础信息页
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
@class DateRecordVO;
@protocol PDDRBaseInfoViewControllerDelegate;



@interface PDDRBaseInfoViewController : PDViewController

@property (nonatomic, strong) DateRecordVO *dRecord;

@property (nonatomic, weak) id<PDDRBaseInfoViewControllerDelegate> delegate;

@end

@protocol PDDRBaseInfoViewControllerDelegate

- (void)onBaseInfoFinishedEditing:(PDDRBaseInfoViewController*)baseInfoVC;

@end