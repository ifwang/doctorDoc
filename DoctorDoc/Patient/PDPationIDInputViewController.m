//
//  PDPationIDInputViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/2.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDPationIDInputViewController.h"
#import "PDAddPatientViewController.h"
#import "PatientRecord.h"



@interface PDPationIDInputViewController ()

@property (nonatomic, strong) NSMutableSet *pidSet;

@end

@implementation PDPationIDInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)numberInputFinish:(NSString *)result
{
    
    if ([_pidSet containsObject:result])
    {
        NSLog(@"pid exist");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"该病人编号已存在";
        [hud hide:YES afterDelay:1];
        
        return;
    }
    else
    {
        PDAddPatientViewController *vc = [[PDAddPatientViewController alloc] init];
        vc.title = @"基本资料";
        
        PatientRecord *pr = [[PatientRecord alloc] init];
        pr.pid = result;
        vc.souceType = PDAddVCSourceTypeAdd;
        vc.patientRecord = pr;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark - Data Method

- (void)setPationList:(NSArray *)list
{
    if (list == nil) {
        return;
    }
    
    if (_pidSet == nil)
    {
        self.pidSet = [[NSMutableSet alloc] init];
    }
    
    [_pidSet addObjectsFromArray:list];
}



@end
