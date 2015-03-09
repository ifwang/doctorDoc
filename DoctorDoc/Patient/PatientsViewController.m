//
//  PatientsViewController.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PatientsViewController.h"
#import "PatientListView.h"
#import "YTKKeyValueStore.h"
#import "PDPationIDInputViewController.h"
#import "PDPatientInfoViewController.h"

@interface PatientsViewController ()<PatientListViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) PatientListView *pView;

@property (nonatomic, strong) NSMutableArray *patientList;

@end

@implementation PatientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   // [self initData];
    
    self.pView = (PatientListView*)self.view;
    _pView.delegate = self;
    [_pView initView];
    //[_pView setPatients:_patientList];
    
    self.title = @"PatientList";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddBtnClicked)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self initData];
    [_pView setPatients:_patientList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - VC Methpd
-(void)onAddBtnClicked
{
    PDPationIDInputViewController *vc = [[PDPationIDInputViewController alloc] init];
    vc.numCount = 2;
    vc.hintText = @"请输入病人ID";
    
    NSMutableArray *pList = [[NSMutableArray alloc] init];
    [_patientList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *pDict = obj;
        [pList addObject:pDict[@"pid"]];
    }];
    [vc setPationList:pList];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - View Delegate Method

- (void)onDeleteCellAtRow:(NSInteger)row
{
    if (row >= _patientList.count)
    {
        NSLog(@"ERROR!!");
        return;
    }
    
    NSDictionary *dict = _patientList[row];
    NSString *pid = dict[@"pid"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:[NSString stringWithFormat:@"确认删除病人 %@",pid] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = row;
    [alert show];

//    
//    [_patientList removeObject:dict];
//    
//    [[PDDBManager shareInstance] deletePid:pid];
    
}

- (void)onSelectCellAtRow:(NSInteger)row
{
    if (row >= _patientList.count)
    {
        NSLog(@"ERROR!!");
        return;
    }
    
    NSDictionary *dict = _patientList[row];
    NSString *pid = dict[@"pid"];
    
    PDPatientInfoViewController *vc = [[PDPatientInfoViewController alloc] init];
    vc.pid = pid;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld", buttonIndex);
    if (buttonIndex == 1)
    {
        NSUInteger row = alertView.tag;
        
        NSDictionary *dict = _patientList[row];
        NSString *pid = dict[@"pid"];
        [_patientList removeObject:dict];
        [[PDDBManager shareInstance] deletePid:pid];
        
        [_pView deleteIdexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    }
    
    
}


#pragma mark - Data Method
- (void)initData
{
    NSArray *pInfoList = [[PDDBManager shareInstance] objectListInTable:kTableNamePatientList];
    self.patientList = [[NSMutableArray alloc] init];
    for (YTKKeyValueItem *item in pInfoList)
    {
        NSString *dateStr = [self stringFromPatientDate:item.createdTime];
        
        [_patientList addObject:@{@"pid":item.itemId,@"date":dateStr}];
    }
}

- (NSString*)stringFromPatientDate:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd";
    
    return [formatter stringFromDate:date];
}



@end
