//
//  PDPatientInfoView.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDPatientInfoView.h"
#import "PDTableViewHeaderTitle.h"

@interface PDPatientInfoView()<PDTableAction>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PDPatientInfoView

- (void)initView
{
    self.datasource = [[PDPatientInfoTableDataSource alloc] init];
    [_datasource registerTableView:_tableView];

    _tableView.dataSource = _datasource;
    _tableView.delegate = _datasource;
    [_tableView reloadData];
}

#pragma mark - data source Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
