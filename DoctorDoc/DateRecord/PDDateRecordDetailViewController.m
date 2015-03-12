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
#import "PDDRBaseInfoViewController.h"

@interface PDDateRecordDetailViewController ()<PDDRBaseInfoViewControllerDelegate>

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
    PDDRBaseInfoViewController *vc = [[PDDRBaseInfoViewController alloc] init];
    DateRecordVO *dateRecord = [[DateRecordVO alloc] init];
    [dateRecord coverBaseInfoByDateRecord:_dateRecord];
    vc.dRecord = dateRecord;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Base Info Delegate Method
- (void)onBaseInfoFinishedEditing:(PDDRBaseInfoViewController *)baseInfoVC
{
    [_dateRecord coverBaseInfoByDateRecord:baseInfoVC.dRecord];
    [_dView reload];
    
    [[PDDBManager shareInstance] putObject:_dateRecord key:_drKey inTable:kTableNameDateRecord];
}

#pragma mark - Data init Method

- (void)initData
{
    self.dateRecord = [[DateRecordVO alloc] initWithDictionary:[[PDDBManager shareInstance] dictionaryWithKey:_drKey inTable:kTableNameDateRecord]];
}



@end
