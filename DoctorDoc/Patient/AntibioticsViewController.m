//
//  AntibioticsViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/5.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "AntibioticsViewController.h"
#import "MGConferenceDatePicker.h"
#import "MGConferenceDatePickerDelegate.h"

@interface AntibioticsViewController ()<UITextFieldDelegate,MGConferenceDatePickerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *useBtn;


@property (weak, nonatomic) IBOutlet FUIButton *doneBtn;

@property (weak, nonatomic) IBOutlet FUIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet MGConferenceDatePicker *pickerView;

@end

@implementation AntibioticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _textField.font = [UIFont lightFlatFontOfSize:18];
    
    _doneBtn.buttonColor = HEXCOLOR(0x019858);
    _doneBtn.highlightedColor = HEXCOLOR(0x003E3E);
    _doneBtn.shadowColor = HEXCOLOR(0x3C3C3C);
    _doneBtn.shadowHeight = 4;
    _doneBtn.cornerRadius = 4;
    [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _doneBtn.titleLabel.font = [UIFont lightFlatFontOfSize:16];
    
    _cancelBtn.buttonColor = HEXCOLOR(0xAE0000);
    _cancelBtn.highlightedColor = HEXCOLOR(0x750000);
    _cancelBtn.shadowColor = HEXCOLOR(0x4D0000);
    _cancelBtn.shadowHeight = 2;
    _cancelBtn.cornerRadius = 4;
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont lightFlatFontOfSize:14];
    
    _textField.text = _antiVO.text;
    
    if (_sourceType == PDVCSourceTypeAdd)
    {
        self.antiVO = [[AntibioticsVO alloc] init];
    }
    else if(_antiVO != nil)
    {
        _textField.text = _antiVO.text;
        [_useBtn setTitle:[self stringFromDate:_antiVO.date] forState:UIControlStateNormal];
    }
    
    self.pickerView.delegate = self;
    self.pickerView.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Delegate
- (IBAction)onDateBtnClicked:(id)sender
{
    [_textField resignFirstResponder];
    [self.view bringSubviewToFront:_pickerView];
    [UIView animateWithDuration:0.2 animations:^{
        _pickerView.alpha = 1;
    }];
    
}

- (IBAction)onDoneBtnClicked:(id)sender
{
    [_textField resignFirstResponder];
    
    if (![self checkDataValid])
    {
        return;
    }
    
    if (_textField.text.length > 0)
    {
        _antiVO.text = _textField.text;
    }
    
    [_delegate AntibioticsViewControllerDidFinishEdit:self];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)onCancelBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)textFieldDoneFinished:(id)sender
{
    [_textField resignFirstResponder];
}

- (IBAction)onViewTap:(id)sender
{
    [_textField resignFirstResponder];
}

- (void)conferenceDatePicker:(MGConferenceDatePicker *)datePicker saveDate:(NSDate *)date
{
    [UIView animateWithDuration:0.2 animations:^{
        _pickerView.alpha = 0;
    } completion:^(BOOL finished) {
       [self.view sendSubviewToBack:_pickerView];
    }];
    
    [_useBtn setTitle:[self stringFromDate:date] forState:UIControlStateNormal];
    _antiVO.date = date;
    
}


#pragma mark - Private Method

- (BOOL)checkDataValid
{
    if (_textField.text.length == 0)
    {
        [self showTextHUD:@"名称不能为空！"];
        return NO;
    }
    
    if (_antiVO.date == nil)
    {
        [self showTextHUD:@"请选择日期"];
        return NO;
    }
    return YES;
}

- (NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    return [formatter stringFromDate:date];
}

@end
