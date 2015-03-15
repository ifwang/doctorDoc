//
//  PDUrineViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/16.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDUrineViewController.h"

@interface PDUrineViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet FUIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet FUIButton *doneBtn;

@end

@implementation PDUrineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    if (_unine.length > 0)
    {
        _textField.text = _unine;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onCancelBtnClicked:(id)sender
{
    [_textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (IBAction)onDoneBtnClicked:(id)sender
{
    [_textField resignFirstResponder];
    _unine = _textField.text;
    [_delegate onUrineVCFinishEditing:self];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)valueDidChanged:(id)sender
{
    _unine = _textField.text;
}

- (IBAction)onViewTap:(id)sender
{
    [_textField resignFirstResponder];
}

- (void)initUI
{
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

}

@end
