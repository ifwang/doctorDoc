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
#import "PDUrineViewController.h"

@interface PDDateRecordDetailViewController ()<PDDRBaseInfoViewControllerDelegate, PDDateRecordDetailViewDelegate, PDFeedViewControllerDelegate, PDUrineViewControllerDelegate, UIActionSheetDelegate>

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
    if (_pRecord != nil)
    {
        [_dView setPatientRecord:_pRecord];
    }
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
    [self showFeedViewController];
}

- (void)onUrineCellSelected
{
    [self showUrineViewController];
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

#pragma mark - Urine Delegate Method

- (void)onUrineVCFinishEditing:(PDUrineViewController*)urineVC
{
    if (urineVC.unine.length > 0)
    {
        _dateRecord.urine = urineVC.unine;
    }
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
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"添加记录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"喂养", @"尿", nil];
    
    [sheet showFromBarButtonItem:item animated:YES];
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (_dateRecord.feed == nil)
        {
            [self showFeedViewController];
        }
        else
        {
            [self showTextHUD:@"喂养记录已存在"];
        }
    }
    else if (buttonIndex == 1)
    {
        [self showUrineViewController];
        
    }
}

#pragma mark - Private Method

- (void)showUrineViewController
{
    PDUrineViewController *vc = [[PDUrineViewController alloc] init];
    if (_dateRecord.urine.length > 0)
    {
        vc.unine = _dateRecord.urine;
    }
    vc.delegate = self;
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)showFeedViewController
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

@end
