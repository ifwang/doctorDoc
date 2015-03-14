//
//  PDFeedViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/14.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDFeedViewController.h"
#import "PDFeedView.h"
#import "PDUIFactory.h"

@interface PDFeedViewController ()

@property (nonatomic, strong) PDFeedView *fView;

@end

@implementation PDFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fView = (PDFeedView*)self.view;
    _fView.fRecord = _feedRecord;
    [_fView initView];
    
    
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
    [_delegate onFeedFinishedEditing:self];
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
