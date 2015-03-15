//
//  PDDatePickerViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/9.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDDatePickerViewController.h"
#import "MGConferenceDatePicker.h"
#import "MGConferenceDatePickerDelegate.h"

@interface PDDatePickerViewController ()<MGConferenceDatePickerDelegate>

@property (nonatomic, weak) IBOutlet MGConferenceDatePicker *picker;

@property (nonatomic, weak) IBOutlet UILabel *titleLbl;

@end

@implementation PDDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _titleLbl.font = [UIFont lightFlatFontOfSize:18];
    _titleLbl.text = _text;
    [self.view bringSubviewToFront:_titleLbl];
    _picker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)conferenceDatePicker:(MGConferenceDatePicker *)datePicker saveDate:(NSDate *)date
{
    [_delegate datePicker:self selectDate:date];
    if (self.navigationController != nil)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.presentingViewController != nil)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)setText:(NSString *)text
{
    _text = text;
    _titleLbl.text = text;
}


- (IBAction)onCancelClicked:(id)sender
{
    if (self.navigationController != nil)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.presentingViewController != nil)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end
