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

@interface PDPatientInfoViewController ()

@property (nonatomic, strong) PDPatientInfoView *pView;

@property (nonatomic, strong) PatientRecord *patientRecord;

@end

@implementation PDPatientInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pView = (PDPatientInfoView*)self.view;
    
    [self initData];
    [_pView initView];
    _pView.datasource.pRecord = _patientRecord;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
