//
//  PDAddPatientViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/2.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDAddPatientViewController.h"
#import "PDAddPatientView.h"
#import "PDTextInputViewController.h"
#import "PDUIFactory.h"
#import "PDDBManager.h"
#import "YTKKeyValueStore.h"

@interface PDAddPatientViewController ()<PDAddPatientViewDelegate,PDTextInputViewControllerDelegate>

@property (nonatomic, strong) PDAddPatientView *pView;

@property (nonatomic, strong) PatientRecord *patientRecord;

@end

@implementation PDAddPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initBarItem];
    
    self.pView = (PDAddPatientView*)self.view;
    _pView.delegate = self;
    [_pView initView];
    
    _pView.datasource.pRecord = _patientRecord;
    [_pView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTextCellSelected
{
    PDTextInputViewController *vc = [[PDTextInputViewController alloc] init];
    vc.delegate = self;
    vc.text = _patientRecord.diagnostic;
    [self.navigationController pushViewController:vc animated:YES];
}

//消息输入完成回调事件
- (void)onTextInputFinish:(PDTextInputViewController*)pTextInputVC
{
    _patientRecord.diagnostic = pTextInputVC.text;
    [_pView reload];
}

#pragma mark - Private method
- (void)initBarItem
{
    FUIButton *button = [PDUIFactory doneButton];
    [button addTarget:self action:@selector(patientRecordDidFinishEdit) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)patientRecordDidFinishEdit
{
    if (![self checkDataValid])
    {
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSLog(@"add patient:\n%@",_patientRecord);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        PDDBManager *manager = [PDDBManager shareInstance];
        
        [manager putString:@"" key:_patientRecord.pid inTable:kTableNamePatientList];
        [manager putObject:_patientRecord key:_patientRecord.pid inTable:kTableNamePatient];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (_souceType == 0)
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                [_delegate onPatientInfoFinished:_patientRecord];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        });
    });
    
    
}



#pragma mark - Private Method

- (BOOL)checkDataValid
{
    if (_patientRecord.weight.length == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入体重";
        [hud hide:YES afterDelay:1];
        return NO;
    }
    if (_patientRecord.headRound.length == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入头围";
        [hud hide:YES afterDelay:1];

        return NO;
    }
    if (_patientRecord.bodyLength.length == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入身长";
        [hud hide:YES afterDelay:1];
        return NO;
    }
    
    
    return YES;
    
}

- (void)setPatientRecord:(PatientRecord *)patientRecord
{
    _patientRecord = [[PatientRecord alloc] init];
    
    _patientRecord.pid = patientRecord.pid;
    _patientRecord.weight = patientRecord.weight;
    _patientRecord.headRound = patientRecord.headRound;
    _patientRecord.bodyLength = patientRecord.bodyLength;
    _patientRecord.diagnostic = patientRecord.diagnostic;
}


@end
