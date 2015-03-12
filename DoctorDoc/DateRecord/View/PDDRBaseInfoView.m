//
//  PDDRBaseInfoView.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDDRBaseInfoView.h"
#import "PDDRBaseInfoDataSource.h"

@interface PDDRBaseInfoView()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PDDRBaseInfoDataSource *datasource;

@end

@implementation PDDRBaseInfoView


- (void)initView
{
    self.datasource = [[PDDRBaseInfoDataSource alloc] init];
    [_datasource registerTableView:_tableView];
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 218, 0)];

}

- (void)setDRecord:(DateRecordVO *)dRecord
{
    _datasource.dRecord = dRecord;
    _dRecord = dRecord;
    [_tableView reloadData];
}











@end
