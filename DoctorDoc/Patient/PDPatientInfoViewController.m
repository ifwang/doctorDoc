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
#import "PDTextInputViewController.h"
#import "PDDatePickerViewController.h"
#import "PDDateRecordListViewController.h"


typedef NS_ENUM(NSUInteger, PDPatientDatePickerType)
{
    PDPatientDatePickerTypeAddPhoto = 0,
    PDPatientDatePickerTypePhoto,
    PDPatientDatePickerTypeHypia ,
    PDPatientDatePickerTypeNewBorn ,
};



@interface PDPatientInfoViewController ()<PDPatientInfoViewDelegate,PDAddPatientViewControllerDelegate,AntibioticsViewControllerDelegate, PDTextInputViewControllerDelegate , PDDatePickerViewControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) PDPatientInfoView *pView;

@property (nonatomic, strong) PatientRecord *patientRecord;

@property (nonatomic, weak) PDDBManager *manager;

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
    
    self.manager = [PDDBManager shareInstance];
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
    [_pView reload];
}

- (void)onBaseInfoBtnClicked
{
    PDAddPatientViewController *vc = [[PDAddPatientViewController alloc] init];
    vc.patientRecord = _patientRecord;
    vc.souceType = PDVCSourceTypeEdit;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)onDialogCellClicked
{
    PDTextInputViewController *vc = [[PDTextInputViewController alloc] init];
    vc.delegate = self;
    vc.text = _patientRecord.diagnostic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onAntiCellSelectedAtRow:(NSUInteger)row
{
    AntibioticsViewController *antiVC = [[AntibioticsViewController alloc] init];
    
    antiVC.sourceType = PDVCSourceTypeEdit;
    antiVC.antiVO = _patientRecord.antibioticsList[row];
    antiVC.delegate = self;
    
    [self presentViewController:antiVC animated:YES completion:^{
        
    }];
}

- (void)onDeleteAntiCellAtRow:(NSUInteger)row
{
    [_patientRecord.antibioticsList removeObjectAtIndex:row];
    
    [_manager putObject:_patientRecord key:_patientRecord.pid inTable:kTableNamePatient];
}

- (void)onPhotoCellSelectedAtRow:(NSUInteger)row
{
    PDDatePickerViewController *picker = [[PDDatePickerViewController alloc] init];
    picker.delegate = self;
    picker.tag = PDPatientDatePickerTypePhoto * 100 + row;
    picker.text = @"选择光疗日期";

    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
    
}

- (void)onDeletePhotoCellAtRow:(NSUInteger)row
{
    [_patientRecord.phototherapyList removeObjectAtIndex:row];
    [_manager putObject:_patientRecord key:_patientRecord.pid inTable:kTableNamePatient];
}

- (void)onHypothermiaCellSelectedAtRow:(NSUInteger)row
{
    PDDatePickerViewController *picker = [[PDDatePickerViewController alloc] init];
    picker.delegate = self;
    picker.tag = PDPatientDatePickerTypeHypia * 100 + row;
    picker.text = @"选择亚低温开始日期";

    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

- (void)onDeleteHypothermiaCell
{
    _patientRecord.hypothermia = nil;
}

- (void)onNewBornCellSelectAtRow:(NSUInteger)row
{
    
    PDDatePickerViewController *picker = [[PDDatePickerViewController alloc] init];
    picker.delegate = self;
    picker.tag = PDPatientDatePickerTypeNewBorn * 100 + row;
    picker.text = @"选择新生儿筛查日期";
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

- (void)onDeleteNewbornCell
{
    _patientRecord.newbornCheck = nil;
}

- (void)onDateRecordCellSelected
{
    PDDateRecordListViewController *vc = [[PDDateRecordListViewController alloc] init];
    vc.pid = _patientRecord.pid;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark - Anti Delegate
- (void)AntibioticsViewControllerDidFinishEdit:(AntibioticsViewController *)antiVC
{
    if (antiVC.sourceType == PDVCSourceTypeAdd)
    {
        [_patientRecord.antibioticsList addObject:antiVC.antiVO];
    }
    
    [_pView reload];
    
    [_manager putObject:_patientRecord key:_patientRecord.pid inTable:kTableNamePatient];
}

#pragma mark - Text Input Delegate

- (void)onTextInputFinish:(PDTextInputViewController*)pTextInputVC
{
    _patientRecord.diagnostic = pTextInputVC.text;
    [_pView reload];
    [_manager putObject:_patientRecord key:_patientRecord.pid inTable:kTableNamePatient];
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
    else if (buttonIndex == 1)
    {
        PDDatePickerViewController *vc = [[PDDatePickerViewController alloc] init];
        vc.delegate = self;
        vc.tag = PDPatientDatePickerTypeAddPhoto * 100;
        vc.text = @"选择新增光疗日期";
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
    else if (buttonIndex == 2)
    {
        PDDatePickerViewController *vc = [[PDDatePickerViewController alloc] init];
        vc.delegate = self;
        vc.tag = PDPatientDatePickerTypeHypia * 100;
        vc.text = @"设置亚低温日期";
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
    else if (buttonIndex == 3)
    {
        PDDatePickerViewController *vc = [[PDDatePickerViewController alloc] init];
        vc.delegate = self;
        vc.tag = PDPatientDatePickerTypeNewBorn * 100;
        vc.text = @"设置新生儿筛查日期";
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
    
}

#pragma mark - Date Picker Delegate Method

- (void)datePicker:(PDDatePickerViewController *)picker selectDate:(NSDate *)date
{
    PDPatientDatePickerType type = picker.tag / 100;
    NSUInteger subRow = picker.tag % 100;
    
    switch (type)
    {
        case PDPatientDatePickerTypeAddPhoto:
        {
            [_patientRecord.phototherapyList addObject:date];
        }
        case PDPatientDatePickerTypePhoto:
        {
            [_patientRecord.phototherapyList replaceObjectAtIndex:subRow withObject:date];
            break;
        }
        case PDPatientDatePickerTypeHypia:
        {
            _patientRecord.hypothermia = date;
            break;
        }
        case PDPatientDatePickerTypeNewBorn:
        {
            _patientRecord.newbornCheck = date;
            break;
        }
    }
    
    [_pView reload];

    [_manager putObject:_patientRecord key:_pid inTable:kTableNamePatient];
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
    
    NSLog(@"pation:\n%@",_patientRecord);
}

- (void)initNavBarItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddItemClicked:)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.title = @"病人资料";
}

- (void)onAddItemClicked:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"添加记录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"抗生素",@"光疗",@"亚低温",@"新生儿筛查", nil];
    [sheet showFromBarButtonItem:sender animated:YES];
    
    
}


@end
