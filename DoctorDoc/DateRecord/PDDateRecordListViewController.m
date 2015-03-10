//
//  PDDateRecordListViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/10.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDDateRecordListViewController.h"
#import "PDDateRecordListView.h"
#import "YTKKeyValueStore.h"
#import "IFIDMaker.h"
#import "DateRecordVO.h"
#import "PDDateRecordDetailViewController.h"


@interface PDDateRecordListViewController ()<PDDateRecordListViewDelegate>

@property (nonatomic, strong) PDDateRecordListView *pView;

@property (nonatomic, strong) NSMutableArray *drList;

@end

@implementation PDDateRecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pView = (PDDateRecordListView*)self.view;
    [_pView initView];
    _pView.delegate = self;
    [self initData];
    [_pView setDateRecordList:_drList];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddDateRecord)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Delegate Method

- (void)onDateRecordCellSelected:(NSUInteger)row
{
    NSDictionary *drDict = _drList[row];
    NSString *drid = drDict[@"drid"];
    
    NSString *drKey = [PDCommon dateRecordKeyWithPid:_pid drid:drid];
    
    PDDateRecordDetailViewController *vc = [[PDDateRecordDetailViewController alloc] init];
    vc.drKey = drKey;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)onDeleteDateRecord:(NSUInteger)row
{
    //删除VO
    NSDictionary *dict = _drList[row];
    NSString *drid = dict[@"drid"];
    [[PDDBManager shareInstance].originalStore deleteObjectById:[PDCommon dateRecordKeyWithPid:_pid drid:drid] fromTable:kTableNameDateRecord];

    //在列表中删除
    [_drList removeObjectAtIndex:row];
    [[PDDBManager shareInstance].originalStore deleteObjectById:_pid fromTable:kTableNameDateRecordList];
}

- (void)onAddDateRecord
{
    //获取递增的DateRecord ID
    NSUInteger newDrid = [[IFIDMaker shareInstance] getIncrementIDWithKey:kTableNameDateRecordList];
    
    //保存列表
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [NSDate date];
    NSDictionary *drDict = @{@"drid":[@(newDrid) stringValue], @"date":[formater stringFromDate:nowDate]};
    [_drList addObject:drDict];
    
    [[PDDBManager shareInstance].originalStore putObject:[NSArray arrayWithArray:_drList] withId:_pid intoTable:kTableNameDateRecordList];
    //保存DRVO
    DateRecordVO *dateRecord = [[DateRecordVO alloc] init];
    dateRecord.drid = @(newDrid).stringValue;
    dateRecord.recordDate = nowDate;
    
    [[PDDBManager shareInstance] putObject:dateRecord key:[PDCommon dateRecordKeyWithPid:_pid drid:dateRecord.drid] inTable:kTableNameDateRecord];
    
    [_pView addDateRecord:drDict];
}

#pragma mark - Data Method

- (void)initData
{
    if (self.pid == nil)
    {
        return;
    }
    
    NSArray *array = [[PDDBManager shareInstance].originalStore getObjectById:_pid fromTable:kTableNameDateRecordList];
    self.drList = [NSMutableArray arrayWithArray:array];
}

@end
