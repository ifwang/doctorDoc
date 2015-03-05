//
//  PDAddPatientView.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/2.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDAddPatientView.h"

@interface PDAddPatientView()<PDTableAction>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PDAddPatientView

- (void)initView
{
    [super initView];
    
    self.datasource = [[PDAddPatientTableDataSource alloc] init];
    _datasource.delegate = self;
    [_datasource registerTableView:_tableView];
    
    _tableView.dataSource = _datasource;
    _tableView.delegate = _datasource;
}

- (void)reload
{
    [_tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        [_delegate onTextCellSelected];
    }
}


@end
