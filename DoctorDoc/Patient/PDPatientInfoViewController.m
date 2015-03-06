//
//  PDPatientInfoViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDPatientInfoViewController.h"
#import "PDPatientInfoView.h"
#import "PatientRecord.h"
#import "PDDBManager.h"
#import "AntibioticsVO.h"
#import "PDAddPatientViewController.h"
#import "AntibioticsViewController.h"

@interface PDPatientInfoViewController ()<PDPatientInfoViewDelegate,PDAddPatientViewControllerDelegate,AntibioticsViewControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) PDPatientInfoView *pView;

@property (nonatomic, strong) PatientRecord *patientRecord;

@end

@implementation PDPatientInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavBarItem];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pView = (PDPatientInfoView*)self.view;
    _pView.delegate = self;
    
    [_pView initView];
    [self initData];
    _pView.patientRecord = _patientRecord;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Method

- (void)onPatientInfoFinished:(PatientRecord *)patientRecord
{
    _patientRecord.weight = patientRecord.weight;
    _patientRecord.headRound = patientRecord.headRound;
    _patientRecord.bodyLength = patientRecord.bodyLength;
    _patientRecord.diagnostic = patientRecord.diagnostic;
    _pView.patientRecord = _patientRecord;
}

- (void)onBaseInfoBtnClicked
{
    PDAddPatientViewController *vc = [[PDAddPatientViewController alloc] init];
    vc.patientRecord = _patientRecord;
    vc.souceType = PDVCSourceTypeEdit;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)AntibioticsViewControllerDidFinishEdit:(AntibioticsViewController *)antiVC
{
    if (antiVC.sourceType == PDVCSourceTypeAdd)
    {
        NSMutableArray *tList = [NSMutableArray arrayWithArray:_patientRecord.antibioticsList];
        [tList addObject:antiVC.antiVO];
        _patientRecord.antibioticsList = [NSArray arrayWithArray:tList];
    }
    
    _pView.patientRecord = _patientRecord;
    
    [[PDDBManager shareInstance] putObject:_patientRecord key:_patientRecord.pid inTable:kTableNamePatient];
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",buttonIndex);
    
    if (buttonIndex == 0)
    {
        AntibioticsViewController *vc = [[AntibioticsViewController alloc] init];
        vc.sourceType = PDVCSourceTypeAdd;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
        
    }
    
}

#pragma mark - Private Method

- (void)initData
{
    if (_pid == nil)
    {
        [self showTextHUD:@"暂无病人资料"];
        return;
    }
    
    PDDBManager *manager = [PDDBManager shareInstance];
    
    self.patientRecord = [[PatientRecord alloc] initWithDictionary:[manager dictionaryWithKey:_pid inTable:kTableNamePatient]];
    
    _patientRecord.antibioticsList = @[[AntibioticsVO mockVO],[AntibioticsVO mockVO]];
    _patientRecord.phototherapyList = @[[NSDate date], [NSDate date]];
    _patientRecord.hypothermia = [NSDate date];
    _patientRecord.newbornCheck = [NSDate date];
    NSLog(@"pation:\n%@",_patientRecord);
}

- (void)initNavBarItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddItemClicked:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)onAddItemClicked:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"添加记录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"抗生素",@"光疗",@"亚低温",@"新生儿筛查", nil];
    [sheet showFromBarButtonItem:sender animated:YES];
    
    
}


@end
