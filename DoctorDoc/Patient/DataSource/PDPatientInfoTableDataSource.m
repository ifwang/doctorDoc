//
//  PDPatientInfoTableDataSource.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/5.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDPatientInfoTableDataSource.h"
#import "PDTextViewTableViewCell.h"
#import "PDInputNumberTableViewCell.h"
#import "PDTableViewHeaderTitle.h"
#import "PatientTextTableViewCell.h"

@interface PDPatientInfoTableDataSource()

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation PDPatientInfoTableDataSource

- (void)registerTableView:(UITableView *)tableView
{
    self.tableView = tableView;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDInputNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDInputNumberTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDTextViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDTextViewTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PatientTextTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PatientTextTableViewCell class])];
    
}

#pragma mark - tableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
        case 1:
        {
            return _pRecord.antibioticsList.count;
        }
        case 2:
        {
            return _pRecord.phototherapyList.count;
        }
        case 3:
        {
            return _pRecord.hypothermia==nil?0:2;
        }
        case 4:
        {
            return _pRecord.newbornCheck == nil?0:1;
        }
        default:
            break;
    }
    return 1;
}

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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            PDTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDTextViewTableViewCell class]) forIndexPath:indexPath];
            [cell setTextViewText:_pRecord.diagnostic];
            
            return cell;
        }
        case 1:
        {
            AntibioticsVO *antiVO = _pRecord.antibioticsList[indexPath.row];
            
            PatientTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PatientTextTableViewCell class]) forIndexPath:indexPath];
            textCell.title = antiVO.text;
            
            NSDate *nowDate = [NSDate date];
            NSTimeInterval timeInter = [nowDate timeIntervalSinceDate:antiVO.date];
            
            textCell.detail = [NSString stringWithFormat:@"已使用 %d 天",(int)timeInter/3600/24];
            
            [textCell setTintFontSzie:18 detailSize:16];
            
            return textCell;
        }
        case 2:
        {
            NSDate *pDate = _pRecord.phototherapyList[indexPath.row];
            
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            formater.dateFormat = @"于 MM-dd 进行光疗";
            
            PatientTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PatientTextTableViewCell class]) forIndexPath:indexPath];
            textCell.title = [formater stringFromDate:pDate];
            textCell.detail = @"";
            [textCell setTintFontSzie:18 detailSize:16];
            
            return textCell;
        }
        case 3:
        {
            PatientTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PatientTextTableViewCell class]) forIndexPath:indexPath];
            [textCell setTintFontSzie:18 detailSize:16];
            
            NSDate *hDate = _pRecord.hypothermia;
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            formater.dateFormat = @"MM-dd HH:mm";
            
            if (indexPath.row == 0)
            {
                textCell.title = @"开始日期";
                textCell.detail = [formater stringFromDate:hDate];
            }
            else
            {
                NSDate *endDate = [NSDate dateWithTimeInterval:60*60*72 sinceDate:hDate];
                textCell.title = @"结束日期";
                textCell.detail = [formater stringFromDate:endDate];
            }
            
            return textCell;
        }
        case 4:
        {
            PatientTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PatientTextTableViewCell class]) forIndexPath:indexPath];
            [textCell setTintFontSzie:18 detailSize:16];
            
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            formater.dateFormat = @"MM-dd HH:mm";
            
            textCell.title = @"筛查日期";
            textCell.detail = [formater stringFromDate:_pRecord.newbornCheck];
            return textCell;
        }
        default:
            break;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    
    return 0;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Cell Height
- (CGFloat)heightForIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0 )
    {
        return [PDTextViewTableViewCell cellHeightWithText:_pRecord.diagnostic];
    }
    else
    {
        return 50;
    }
}

- (CGFloat)headerHeightForSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return kPDTableViewHeaderTitleHeight;
        }
        case 1:
        {
            return (_pRecord.antibioticsList.count == 0)?0:kPDTableViewHeaderTitleHeight;

        }
        case 2:
        {
            return (_pRecord.phototherapyList.count == 0)?0:kPDTableViewHeaderTitleHeight;
        }
        case 3:
        {
            return _pRecord.hypothermia==nil?0:kPDTableViewHeaderTitleHeight;
        }
        case 4:
        {
            return _pRecord.newbornCheck==nil?0:kPDTableViewHeaderTitleHeight;
        }
        default:
            return 0;
    }
    
}

- (UIView*)headerForSection:(NSInteger)section
{
    PDTableViewHeaderTitle *header = [[PDTableViewHeaderTitle alloc] init];
    [header initView];
    
    if (section == 0)
    {
        header.title = @"诊断";
        header.mainColor = HEXCOLOR(0x842B00);
    }
    else if (section == 1)
    {
        if (_pRecord.antibioticsList.count == 0)
        {
            return nil;
        }
        
        header.title = @"抗生素";
        header.mainColor = HEXCOLOR(0x003D79);
    }
    else if (section == 2)
    {
        if (_pRecord.phototherapyList.count == 0)
        {
            return nil;
        }
        
        header.title = @"光疗";
        header.mainColor = HEXCOLOR(0x1814A);
    }
    else if (section == 3)
    {
        if (_pRecord.hypothermia == nil)
        {
            return nil;
        }
        
        header.title = @"亚低温";
        header.mainColor = HEXCOLOR(0x005AB5);

    }
    else if (section == 4)
    {
        if (_pRecord.newbornCheck == nil)
        {
            return nil;
        }
        
        header.title = @"新生儿筛查";
        header.mainColor = HEXCOLOR(0x743A3A);
    }
    
    
    return header;
}
#pragma mark - Private Method
- (void)setPRecord:(PatientRecord *)pRecord
{
    _pRecord = pRecord;
    [_tableView reloadData];
}



@end
