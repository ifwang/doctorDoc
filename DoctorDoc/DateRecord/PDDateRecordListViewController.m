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
    
}

- (void)onDeleteDateRecord:(NSUInteger)row
{
    [_drList removeObjectAtIndex:row];
    
    [[PDDBManager shareInstance].originalStore deleteObjectById:_pid fromTable:kTableNameDateRecordList];
}

- (void)onAddDateRecord
{
    NSUInteger newDrid = [[IFIDMaker shareInstance] getIncrementIDWithKey:kTableNameDateRecordList];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd";
    
    NSDictionary *drDict = @{@"drid":[@(newDrid) stringValue], @"date":[formater stringFromDate:[NSDate date]]};
    
    [_drList addObject:drDict];
    
    [[PDDBManager shareInstance].originalStore putObject:[NSArray arrayWithArray:_drList] withId:_pid intoTable:kTableNameDateRecordList];
    
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
