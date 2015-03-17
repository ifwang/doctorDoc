//
//  PDStoolDataSource.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/16.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDStoolDataSource.h"
#import "PDInputNumberTableViewCell.h"
#import "PatientTextTableViewCell.h"

@interface PDStoolDataSource()<PDInputNumberTableViewCellDelegate>

@end

@implementation PDStoolDataSource

- (void)registerTableView:(UITableView *)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDInputNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDInputNumberTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PatientTextTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PatientTextTableViewCell class])];

    
}

#pragma mark - TableView DatatSource Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case PDStoolRowTypeTimes:
        {
            PDInputNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDInputNumberTableViewCell class]) forIndexPath:indexPath];
            
            cell.title = @"次数";
            cell.unit = @"次";
            cell.delegate = self;
            cell.value = @(_stoolVO.times).stringValue;
            [cell setTintFontSzie:20 valueSize:20];
            
            return cell;
        }
        case PDStoolRowTypeColor:
        {
            PatientTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PatientTextTableViewCell class]) forIndexPath:indexPath];
            
            cell.title = @"颜色";
            if (_stoolVO.stoolColor.length > 0)
            {
                cell.detail = _stoolVO.stoolColor;
            }
            else
            {
                cell.detail = @"请点击选择";
            }
            [cell setTintFontSzie:20 detailSize:18];
            return cell;
            
        }
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)onInputNumberTableViewCellInputFinished:(PDInputNumberTableViewCell*)cell
{
    _stoolVO.times = cell.value.intValue;
}


@end
