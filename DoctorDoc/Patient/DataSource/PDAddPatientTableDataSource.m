//
//  PDAddPatientTableDataSource.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDAddPatientTableDataSource.h"
#import "PDInputNumberTableViewCell.h"
#import "PDTextViewTableViewCell.h"
#import "PDTableViewHeaderTitle.h"
#import "PDTextInputViewController.h"

@interface PDAddPatientTableDataSource()<PDInputNumberTableViewCellDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation PDAddPatientTableDataSource

- (void)registerTableView:(UITableView *)tableView
{
    self.tableView = tableView;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDInputNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDInputNumberTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDTextViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDTextViewTableViewCell class])];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [self p_baseInfoCellInTableView:tableView indexPath:indexPath];
        return cell;
    }
    else if (indexPath.section  == 1)
    {
        PDTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDTextViewTableViewCell class]) forIndexPath:indexPath];
        [cell setTextViewText:_pRecord.diagnostic];
        return cell;
    }
    return nil;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return [self headerHeightForSection:section];
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerForSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 1;
    }
    
    return 0;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [[UIView alloc] init];
}


#pragma mark - Cell Height
- (CGFloat)heightForIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0 )
    {
        return 60;
    }
    else if (indexPath.section == 1)
    {
        return 150;
    }
    
    return 0;
    
}

- (CGFloat)headerHeightForSection:(NSInteger)section
{
    return kPDTableViewHeaderTitleHeight;
}

- (UIView*)headerForSection:(NSInteger)section
{
    PDTableViewHeaderTitle *header = [[PDTableViewHeaderTitle alloc] init];
    [header initView];

    if (section == 0)
    {
        header.title = @"Base Info";
        header.mainColor = HEXCOLOR(0x842B00);
    }
    else if (section == 1)
    {
        header.title = @"诊断";
        header.mainColor = HEXCOLOR(0x003D79);
    }
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Num Input Cell Delegate

- (void)onInputNumberTableViewCellInputFinished:(PDInputNumberTableViewCell *)cell
{
    if (cell.indexPath == nil)
    {
        return;
    }
    
    switch (cell.indexPath.row)
    {
        case 1:
        {
            _pRecord.weight = cell.value;
            break;
        }
        case 2:
        {
            _pRecord.headRound = cell.value;
            break;
        }
        case 3:
        {
            _pRecord.bodyLength = cell.value;
            break;
        }
        default:
            break;
    }
    
    
}

#pragma mark - Private Method

- (UITableViewCell*)p_baseInfoCellInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath
{
    PDInputNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDInputNumberTableViewCell class]) forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    switch (indexPath.row)
    {
        case 0:
        {
            //病人ID
            cell.title = @"病人ID";
            cell.value = _pRecord.pid;
            cell.unit = @"";
            cell.inputAble = NO;
            break;
        }
        case 1:
        {
            cell.title = @"体重";
            cell.unit = @"kg";
            break;
        }
        case 2:
        {
            cell.title = @"头围";
            cell.unit = @"cm";
            break;
        }
        case 3:
        {
            cell.title = @"身长";
            cell.unit = @"cm";
            break;
        }
        default:
            break;
    }
    
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


@end
