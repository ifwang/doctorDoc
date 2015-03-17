//
//  PDTCBView.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTCBView.h"
#import "PDTCBDataSource.h"

@interface PDTCBView()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PDTCBDataSource *dataSource;

@end

@implementation PDTCBView

- (void)initView
{
    self.dataSource = [[PDTCBDataSource alloc] init];
    _dataSource.tcb = _tcb;
    [_dataSource registerTableView:_tableView];
}

@end
