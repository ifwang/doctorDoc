//
//  PDTCBViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTCBViewController.h"
#import "PDTCBView.h"

@interface PDTCBViewController ()

@property (nonatomic, strong) PDTCBView *tView;

@end

@implementation PDTCBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addDoneNaviItem];
    self.tView = (PDTCBView*)self.view;
    _tView.tcb = _tcbVO;
    [_tView initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)onDone
{
    [_delegate onTCBVCFinishEditing:self];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
