//
//  PDTCBDataSource.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTCBDataSource.h"
#import "PDInputNumberTableViewCell.h"

@interface PDTableDataSource()<PDInputNumberTableViewCellDelegate>

@end

@implementation PDTCBDataSource

- (void)registerTableView:(UITableView *)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDInputNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDInputNumberTableViewCell class])];

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
    PDInputNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDInputNumberTableViewCell class]) forIndexPath:indexPath];
    
    [cell setTintFontSzie:20 valueSize:20];
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    
    switch (indexPath.row)
    {
        case 0:
            cell.title = @"TCB1";
            if (_tcb.value1.length > 0)
            {
                cell.value = _tcb.value1;
            }
            break;
        case 1:
        {
            cell.title = @"TCB2";
            if (_tcb.value2.length > 0)
            {
                cell.value = _tcb.value2;
            }

            break;
        }
        case 2:
        {
            cell.title = @"TCB3";
            if (_tcb.value3.length > 0)
            {
                cell.value = _tcb.value3;
            }
        }
        default:
            break;
    }
    
    return cell;
}


- (void)onInputNumberTableViewCellInputFinished:(PDInputNumberTableViewCell *)cell
{
    switch (cell.indexPath.row) {
        case 0:
        {
            _tcb.value1 = cell.value;
            break;
        }
        case 1:
        {
            _tcb.value2 = cell.value;
            break;
        }
        case 2:
        {
            _tcb.value3 = cell.value;
        }
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

@end
