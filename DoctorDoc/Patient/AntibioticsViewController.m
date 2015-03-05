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

@end

@implementation AntibioticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _textField.font = [UIFont lightFlatFontOfSize:18];
    
    _doneBtn.buttonColor = HEXCOLOR(0x019858);
    _doneBtn.highlightedColor = HEXCOLOR(0x003E3E);
    _doneBtn.shadowColor = HEXCOLOR(0x3C3C3C);
    _doneBtn.shadowHeight = 2;
    _doneBtn.cornerRadius = 4;
    [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _doneBtn.titleLabel.font = [UIFont lightFlatFontOfSize:16];
    
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
