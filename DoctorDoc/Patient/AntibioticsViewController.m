//
//  AntibioticsViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/5.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "AntibioticsViewController.h"

@interface AntibioticsViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *useBtn;


@property (weak, nonatomic) IBOutlet FUIButton *doneBtn;

@property (weak, nonatomic) IBOutlet FUIButton *cancelBtn;

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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Delegate
- (IBAction)onDateBtnClicked:(id)sender
{
    
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
    
    _antiVO.date = [NSDate date];
    
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

#pragma mark - Private Method

- (BOOL)checkDataValid
{
    if (_textField.text.length == 0)
    {
        [self showTextHUD:@"名称不能为空！"];
        return NO;
    }
    
    return YES;
}

@end
