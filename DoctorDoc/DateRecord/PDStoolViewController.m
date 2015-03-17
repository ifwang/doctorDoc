//
//  PDStoolViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/16.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDStoolViewController.h"
#import "PDStoolView.h"
#import "PDUIFactory.h"

@interface PDStoolViewController ()

@property (nonatomic, strong) PDStoolView *sView;

@end

@implementation PDStoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initBarItem];
    
    self.sView = (PDStoolView*)self.view;
    _sView.stool = _stool;
    [_sView initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBarItem
{
    [self addDoneNaviItem];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


- (void)onDone
{
    [_delegate onStoolVCFinishEditing:self];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
