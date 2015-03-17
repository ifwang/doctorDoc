//
//  PDInspectDataSource.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDInspectDataSource.h"
#import "PDSwitchTableViewCell.h"

@interface PDInspectDataSource()<PDSwitchTableViewCellDelegate>

@end

@implementation PDInspectDataSource

- (void)registerTableView:(UITableView *)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDSwitchTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDSwitchTableViewCell class])];
}

#pragma mark - TableView Delegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDSwitchTableViewCell class]) forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.tag = indexPath.row;
    switch (indexPath.row)
    {
        case 0:
        {
            cell.title = @"MR";
            cell.value = _inspect.MR;
            break;
        }
        case 1:
        {
            cell.title = @"超声";
            cell.value = _inspect.ultrasound;
            break;
        }
        case 2:
        {
            cell.title = @"胸片";
            cell.value = _inspect.chest;
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - Swicth Delegate

- (void)switchCellValueChange:(PDSwitchTableViewCell *)switchCell
{
    switch (switchCell.tag)
    {
        case 0:
        {
            _inspect.MR = switchCell.value;
            break;
        }
        case 1:
        {
            _inspect.ultrasound = switchCell.value;
            break;
        }
        case 2:
        {
            _inspect.chest = switchCell.value;
            break;
        }
        default:
            break;
    }
}







@end
