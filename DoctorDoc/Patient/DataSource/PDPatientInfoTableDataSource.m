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
        case PDPatientInfoTableSectionTypeDialog:
        {
            return 1;
        }
        case PDPatientInfoTableSectionTypeAnti:
        {
            return _pRecord.antibioticsList.count;
        }
        case PDPatientInfoTableSectionTypePhoto:
        {
            return _pRecord.phototherapyList.count;
        }
        case PDPatientInfoTableSectionTypehypothermia:
        {
            return _pRecord.hypothermia==nil?0:2;
        }
        case PDPatientInfoTableSectionTypeNewBorn:
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
        case PDPatientInfoTableSectionTypeDialog:
        {
            PDTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDTextViewTableViewCell class]) forIndexPath:indexPath];
            [cell setTextViewText:_pRecord.diagnostic];
            
            return cell;
        }
        case PDPatientInfoTableSectionTypeAnti:
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
        case PDPatientInfoTableSectionTypePhoto:
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
        case PDPatientInfoTableSectionTypehypothermia:
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
                textCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return textCell;
        }
        case PDPatientInfoTableSectionTypeNewBorn:
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
    if (section == PDPatientInfoTableSectionTypeNewBorn)
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
    
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Table Delegate Delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == PDPatientInfoTableSectionTypeAnti || indexPath.section == PDPatientInfoTableSectionTypePhoto || indexPath.section == PDPatientInfoTableSectionTypehypothermia || indexPath.section == PDPatientInfoTableSectionTypeNewBorn)
    {
        return YES;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.delegate tableView:tableView deleteCellforRowAtIndexPath:indexPath];
        
//        [_delegate onDeleteCellAtRow:indexPath.row];
//        [_listArrary removeObjectAtIndex:indexPath.row];
//        // Delete the row from the data source.
//        [_tableView beginUpdates];

        if (indexPath.section == PDPatientInfoTableSectionTypehypothermia)
        {
            [_tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationRight];
        }
        else
        {
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


#pragma mark - Cell Height
- (CGFloat)heightForIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == PDPatientInfoTableSectionTypeDialog )
    {
        return [PDTextViewTableViewCell cellHeightWithText:_pRecord.diagnostic] + 30;
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
        case PDPatientInfoTableSectionTypeDialog:
        {
            return kPDTableViewHeaderTitleHeight;
        }
        case PDPatientInfoTableSectionTypeAnti:
        {
            return (_pRecord.antibioticsList.count == 0)?0:kPDTableViewHeaderTitleHeight;

        }
        case PDPatientInfoTableSectionTypePhoto:
        {
            return (_pRecord.phototherapyList.count == 0)?0:kPDTableViewHeaderTitleHeight;
        }
        case PDPatientInfoTableSectionTypehypothermia:
        {
            return _pRecord.hypothermia==nil?0:kPDTableViewHeaderTitleHeight;
        }
        case PDPatientInfoTableSectionTypeNewBorn:
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
    
    if (section == PDPatientInfoTableSectionTypeDialog)
    {
        header.title = @"诊断";
        header.mainColor = HEXCOLOR(0x842B00);
    }
    else if (section == PDPatientInfoTableSectionTypeAnti)
    {
        if (_pRecord.antibioticsList.count == 0)
        {
            return nil;
        }
        
        header.title = @"抗生素";
        header.mainColor = HEXCOLOR(0x003D79);
    }
    else if (section == PDPatientInfoTableSectionTypePhoto)
    {
        if (_pRecord.phototherapyList.count == 0)
        {
            return nil;
        }
        
        header.title = @"光疗";
        header.mainColor = HEXCOLOR(0x1814A);
    }
    else if (section == PDPatientInfoTableSectionTypehypothermia)
    {
        if (_pRecord.hypothermia == nil)
        {
            return nil;
        }
        
        header.title = @"亚低温";
        header.mainColor = HEXCOLOR(0x005AB5);

    }
    else if (section == PDPatientInfoTableSectionTypeNewBorn)
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
