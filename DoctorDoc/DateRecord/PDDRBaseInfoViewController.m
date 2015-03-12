//
//  PDDRBaseInfoViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDDRBaseInfoViewController.h"
#import "PDDRBaseInfoView.h"
#import "PDUIFactory.h"

@interface PDDRBaseInfoViewController ()

@property (nonatomic, weak) PDDRBaseInfoView *dView;

@end

@implementation PDDRBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"基础记录";
    self.dView = (PDDRBaseInfoView*)self.view;
    [_dView initView];
    _dView.dRecord = _dRecord;
    
    UIButton *doneButton = [PDUIFactory doneButton];
    [doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneButtonClicked:(id)sender
{
    [_delegate onBaseInfoFinishedEditing:self];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
