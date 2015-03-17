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
#import "PDStoolViewController.h"
#import "PDTCBViewController.h"
#import "PDInspectViewController.h"

@interface PDDateRecordDetailViewController ()<PDDRBaseInfoViewControllerDelegate, PDDateRecordDetailViewDelegate, PDFeedViewControllerDelegate, PDUrineViewControllerDelegate, PDStoolViewControllerDelegate, PDTCBViewControllerDelegate, PDInspectViewControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) DateRecordVO *dateRecord;

@property (nonatomic, weak) PDDateRecordDetailView *dView;

@property (nonatomic, strong) NSMutableArray *sheetTypeArray;

@end

@implementation PDDateRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.sheetTypeArray = [NSMutableArray array];
    
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

- (void)onStoolCellSelected
{
    [self showStoolViewCtroller];
}

- (void)onTCBCellSelected
{
    [self showTCBViewController];
}

- (void)onInspectCellSelected
{
    [self showInspectViewController];
}

#pragma mark - Base Info Delegate Method
- (void)onBaseInfoFinishedEditing:(PDDRBaseInfoViewController *)baseInfoVC
{
    [_dateRecord coverBaseInfoByDateRecord:baseInfoVC.dRecord];
    [_dView reload];
    
    [[PDDBManager shareInstance] putObject:_dateRecord key:_drKey inTable:kTableNameDateRecord];
}

#pragma mark - Sub View Controller Delegate Method

- (void)onFeedFinishedEditing:(PDFeedViewController *)feedVC
{
    _dateRecord.feed = feedVC.feedRecord;
    [_dView reload];
    
    [[PDDBManager shareInstance] putObject:_dateRecord key:_drKey inTable:kTableNameDateRecord];

}


- (void)onUrineVCFinishEditing:(PDUrineViewController*)urineVC
{
    if (urineVC.unine.length > 0)
    {
        _dateRecord.urine = urineVC.unine;
    }
    [_dView reload];
    [[PDDBManager shareInstance] putObject:_dateRecord key:_drKey inTable:kTableNameDateRecord];
    
}

- (void)onStoolVCFinishEditing:(PDStoolViewController *)stoolVC
{
    _dateRecord.stool = stoolVC.stool;
    [_dView reload];
    
    [[PDDBManager shareInstance] putObject:_dateRecord key:_drKey inTable:kTableNameDateRecord];

}

- (void)onTCBVCFinishEditing:(PDTCBViewController *)tcbVC
{
    _dateRecord.tcb = tcbVC.tcbVO;
    [_dView reload];
    
    [[PDDBManager shareInstance] putObject:_dateRecord key:_drKey inTable:kTableNameDateRecord];

}

- (void)onInspectVCFinishEditing:(PDInspectViewController *)inspectVC
{
    _dateRecord.inspect = inspectVC.inspect;
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
    
    NSMutableArray *values = [NSMutableArray array];
    [_sheetTypeArray removeAllObjects];
    
    if (_dateRecord.feed == nil)
    {
        [values addObject:@"喂养"];
        [_sheetTypeArray addObject:@(PDDRDetailRowTypeFeed)];
    }
    if (_dateRecord.urine.length == 0)
    {
        [values addObject:@"尿"];
        [_sheetTypeArray addObject:@(PDDRDetailRowTypeUrine)];
    }
    if (_dateRecord.stool == nil)
    {
        [values addObject:@"便便"];
        [_sheetTypeArray addObject:@(PDDRDetailRowTypeStool)];
    }
    if (_dateRecord.tcb == nil)
    {
        [values addObject:@"TCB"];
        [_sheetTypeArray addObject:@(PDDRDetailRowTypeTCB)];
    }
    if (_dateRecord.inspect == nil)
    {
        [values addObject:@"送检"];
        [_sheetTypeArray addObject:@(PDDRDetailRowTypeInspect)];
    }
    
    if (values.count == 0)
    {
        [self showTextHUD:@"没有记录可添加"];
        return;
    }
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"添加记录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [sheet addButtonWithTitle:obj];
    }];
    
    [sheet showFromBarButtonItem:item animated:YES];
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet cancelButtonIndex])
    {
        return;
    }
    
    NSUInteger type = [_sheetTypeArray[buttonIndex - 1] integerValue];
    
    
    
    if (type == PDDRDetailRowTypeFeed)
    {
        [self showFeedViewController];
    }
    else if (type == PDDRDetailRowTypeUrine)
    {
        [self showUrineViewController];
    }
    else if (type == PDDRDetailRowTypeStool)
    {
        [self showStoolViewCtroller];
    }
    else if (type == PDDRDetailRowTypeTCB)
    {
        [self showTCBViewController];
    }
    else if (type == PDDRDetailRowTypeInspect)
    {
        [self showInspectViewController];
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

- (void)showStoolViewCtroller
{
    PDStoolViewController *vc = [[PDStoolViewController alloc] init];
    StoolVO *stool = nil;
    if (_dateRecord.stool == nil)
    {
        stool = [[StoolVO alloc] init];
    }
    else
    {
        stool = [[StoolVO alloc] initWithDictionary:_dateRecord.stool.dictionary];
    }
    
    vc.delegate = self;
    vc.stool = stool;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showTCBViewController
{
    PDTCBViewController *vc = [[PDTCBViewController alloc] init];
    TCBVO *tcb = nil;
    
    if (_dateRecord.tcb == nil)
    {
        tcb = [[TCBVO alloc] init];
    }
    else
    {
        tcb = [[TCBVO alloc] initWithDictionary:_dateRecord.tcb.dictionary];
    }
    
    vc.delegate = self;
    vc.tcbVO =tcb;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showInspectViewController
{
    PDInspectViewController *vc = [[PDInspectViewController alloc] init];
    
    InspectVO *ins = nil;
    
    if (_dateRecord.inspect == nil)
    {
        ins = [[InspectVO alloc] init];
    }
    else
    {
        ins = [[InspectVO alloc] initWithDictionary:_dateRecord.inspect.dictionary];
    }
    
    vc.delegate = self;
    vc.inspect = ins;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
