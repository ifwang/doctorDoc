//
//  PDDatePickerViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/9.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
@protocol PDDatePickerViewControllerDelegate;


@interface PDDatePickerViewController : PDViewController

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, weak) id<PDDatePickerViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString *text;

@end

@protocol PDDatePickerViewControllerDelegate


- (void)datePicker:(PDDatePickerViewController*)picker selectDate:(NSDate*)date;

@end