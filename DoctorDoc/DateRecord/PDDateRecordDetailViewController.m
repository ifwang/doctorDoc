//
//  PDDateRecordDetailViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/10.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDDateRecordDetailViewController.h"
#import "DateRecordVO.h"
#import "PDDateRecordDetailView.h"

@interface PDDateRecordDetailViewController ()

@property (nonatomic, strong) DateRecordVO *dateRecord;

@property (nonatomic, weak) PDDateRecordDetailView *dView;

@end

@implementation PDDateRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dView = (PDDateRecordDetailView*)self.view;
    [_dView initView];
    
    [self initData];
    _dView.drKey = _drKey;
    _dView.dRecord = _dateRecord;
    [_dView reload];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Delegate Method

- (IBAction)onBaseInfoBtnClicked:(id)sender
{

}

#pragma mark - Data init Method

- (void)initData
{
    self.dateRecord = [DateRecordVO mockVO];
}



@end
