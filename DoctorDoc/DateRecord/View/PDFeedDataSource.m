//
//  PDFeedDataSource.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/14.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDFeedDataSource.h"
#import "PatientTextTableViewCell.h"
#import "PDInputNumberTableViewCell.h"
#import "PDSwitchTableViewCell.h"

@interface PDFeedDataSource()<PDInputNumberTableViewCellDelegate, PDSwitchTableViewCellDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation PDFeedDataSource

- (void)registerTableView:(UITableView *)tableView
{
    self.tableView = tableView;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PatientTextTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PatientTextTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDInputNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDInputNumberTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDSwitchTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDSwitchTableViewCell class])];


}

#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case PDFeedRowTypeFeedWay:
        {
            PatientTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PatientTextTableViewCell class]) forIndexPath:indexPath];
            
            textCell.title = @"方式";
            
            if (_fRecord.feedWay.length > 0)
            {
                textCell.detail = _fRecord.feedWay;
            }
            else
            {
                textCell.detail = @"请点击选择";
            }
            [textCell setTintFontSzie:20 detailSize:18];
            return textCell;
        }
        case PDFeedRowTypeMilkType:
        {
            PatientTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PatientTextTableViewCell class]) forIndexPath:indexPath];
            
            textCell.title = @"喂奶";
            
            if (_fRecord.milkType.length > 0)
            {
                textCell.detail = _fRecord.milkType;
            }
            else
            {
                textCell.detail = @"请点击选择";
            }
            [textCell setTintFontSzie:20 detailSize:18];

            return textCell;
        }
        case PDFeedRowTypeVomit:
        {
            PDSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDSwitchTableViewCell class]) forIndexPath:indexPath];
            
            cell.title = @"呕吐";
            cell.value = _fRecord.vomit;
            cell.delegate = self;
            return cell;
        }
        case PDFeedRowTypeTotalValue:
        {
            PDInputNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDInputNumberTableViewCell class]) forIndexPath:indexPath];
            
            cell.title = @"总共";
            cell.unit = @"ML";
            cell.delegate = self;
            cell.indexPath = indexPath;
            cell.tag = indexPath.row;
            if (_fRecord.totleValue.length > 0)
            {
                cell.value = _fRecord.totleValue;
            }
            [cell setTintFontSzie:20 valueSize:18];
            return cell;
        }
        case PDFeedRowTypePerDateValue1:
        {
            PDInputNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDInputNumberTableViewCell class]) forIndexPath:indexPath];
            
            cell.title = @"每日1";
            cell.unit = @"ML";
            cell.delegate = self;
            cell.indexPath = indexPath;
            cell.tag = indexPath.row;

            if (_fRecord.perVlaue1.length > 0)
            {
                cell.value = _fRecord.perVlaue1;
            }
            [cell setTintFontSzie:20 valueSize:18];

            return cell;
        }
        case PDFeedRowTypePerDateValue2:
        {
            PDInputNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDInputNumberTableViewCell class]) forIndexPath:indexPath];
            
            cell.title = @"每日2";
            cell.unit = @"ML";
            cell.delegate = self;
            cell.indexPath = indexPath;
            cell.tag = indexPath.row;

            if (_fRecord.perVlaue2.length > 0)
            {
                cell.value = _fRecord.perVlaue2;
            }
            [cell setTintFontSzie:20 valueSize:18];

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    if (indexPath.row == PDFeedRowTypeFeedWay || indexPath.row == PDFeedRowTypeMilkType)
    {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }

}

#pragma mark - TableView Header And Footer

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - Swicth Cell Delegate

- (void)switchCellValueChange:(PDSwitchTableViewCell *)switchCell
{
    _fRecord.vomit = switchCell.value;
}

#pragma mark - Num Input Cell Delegate
- (void)onTextFieldBeginEditing:(PDInputNumberTableViewCell *)cell
{
    CGRect rect = [_tableView rectForRowAtIndexPath:cell.indexPath];
    NSLog(@"rect : %@ , y:%f , re:%f",NSStringFromCGRect(rect), _tableView.contentOffset.y, rect.origin.y -  _tableView.contentOffset.y);
    
    CGFloat re = rect.origin.y -  _tableView.contentOffset.y;
    
    if (re > 300)
    {
        [_tableView setContentOffset:CGPointMake(0, _tableView.contentOffset.y  +  re - 200) animated:YES];
    }
}

- (void)onInputNumberTableViewCellInputFinished:(PDInputNumberTableViewCell *)cell
{
    switch (cell.indexPath.row)
    {
        case PDFeedRowTypeTotalValue:
        {
            _fRecord.totleValue = cell.value;
            break;
        }
        case PDFeedRowTypePerDateValue1:
        {
            _fRecord.perVlaue1 = cell.value;
            break;
        }
        case PDFeedRowTypePerDateValue2:
        {
            _fRecord.perVlaue2 = cell.value;
            break;
        }
        default:
            break;
    }
}

@end
