//
//  PDInspectViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDInspectViewController.h"
#import "PDInspectView.h"
@interface PDInspectViewController ()

@property (nonatomic, strong) PDInspectView *inspectView;

@end

@implementation PDInspectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addDoneNaviItem];
    
    self.inspectView = (PDInspectView*)self.view;
    _inspectView.inspect = _inspect;
    [_inspectView initView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onDone
{
    [_delegate onInspectVCFinishEditing:self];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
