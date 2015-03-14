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
#import "PDFeedViewController.h"

@interface PDDateRecordDetailViewController ()<PDDRBaseInfoViewControllerDelegate, PDDateRecordDetailViewDelegate, PDFeedViewControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) DateRecordVO *dateRecord;

@property (nonatomic, weak) PDDateRecordDetailView *dView;

@end

@implementation PDDateRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initBarItem];
    self.dView = (PDDateRecordDetailView*)self.view;
    
    [self initData];
    _dView.drKey = _drKey;
    _dView.dRecord = _dateRecord;
    _dView.delegate = self;
    [_dView initView];
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

- (void)onFeedCellSelected
{
    PDFeedViewController *vc = [[PDFeedViewController alloc] init];
    
    FeedRecordVO *feedRecord = nil;
    if (_dateRecord.feed == nil)
    {
        feedRecord = [[FeedRecordVO alloc] init];
    }
    else
    {
        feedRecord = [[FeedRecordVO alloc] initWithDictionary:_dateRecord.feed.dictionary];
    }
    
    vc.feedRecord = feedRecord;
    vc.delegate = self;
    vc.title = @"喂养";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Base Info Delegate Method
- (void)onBaseInfoFinishedEditing:(PDDRBaseInfoViewController *)baseInfoVC
{
    [_dateRecord coverBaseInfoByDateRecord:baseInfoVC.dRecord];
    [_dView reload];
    
    [[PDDBManager shareInstance] putObject:_dateRecord key:_drKey inTable:kTableNameDateRecord];
}

#pragma mark - Feed Delegate Method

- (void)onFeedFinishedEditing:(PDFeedViewController *)feedVC
{
    _dateRecord.feed = feedVC.feedRecord;
    [_dView reload];
    
    [[PDDBManager shareInstance] putObject:_dateRecord key:_drKey inTable:kTableNameDateRecord];

}

#pragma mark - Data init Method

- (void)initData
{
    self.dateRecord = [[DateRecordVO alloc] initWithDictionary:[[PDDBManager shareInstance] dictionaryWithKey:_drKey inTable:kTableNameDateRecord]];
}

#pragma mark - Private Method

- (void)initBarItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDateRecordElement:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)addDateRecordElement:(id)sender
{
    UIBarButtonItem *item = sender;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"添加记录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"喂养", nil];
    
    [sheet showFromBarButtonItem:item animated:YES];
}

#pragma mark Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (_dateRecord.feed == nil)
        {
            [self onFeedCellSelected];
        }
        else
        {
            [self showTextHUD:@"喂养记录已存在"];
        }
    }
    
    
}

@end
