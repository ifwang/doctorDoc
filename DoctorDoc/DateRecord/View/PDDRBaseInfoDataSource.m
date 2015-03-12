//
//  PDDRBaseInfoDataSource.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDDRBaseInfoDataSource.h"
#import "PatientTextTableViewCell.h"
#import "PDSwitchTableViewCell.h"
#import "PDInputNumberTableViewCell.h"

@interface PDDRBaseInfoDataSource()<PDSwitchTableViewCellDelegate,PDInputNumberTableViewCellDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation PDDRBaseInfoDataSource

- (void)registerTableView:(UITableView *)tableView
{
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:@"PatientTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PatientTextTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:@"PDSwitchTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDSwitchTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:@"PDInputNumberTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDInputNumberTableViewCell class])];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case PDDRBaseInfoRowTypeRadio:
        case PDDRBaseInfoRowTypeWarnbox:
        case PDDRBaseInfoRowTypeHotBed:
        case PDDRBaseInfoRowTypeLowOxy:
        {
            return [self p_switchTableCellWithTableView:tableView indexPath:indexPath];
        }
        case PDDRBaseInfoRowTypeBodyTem1:
        case PDDRBaseInfoRowTypeBodyTem2:
        case PDDRBaseInfoRowTypeHeartRate1:
        case PDDRBaseInfoRowTypeHeartRate2:
        case PDDRBaseInfoRowTypeBreath1:
        case PDDRBaseInfoRowTypeBreath2:
        case PDDRBaseInfoRowTypeBloodOxy1:
        case PDDRBaseInfoRowTypeBloodOxy2:
        {
            return [self p_numberCellWithTableView:tableView indexPath:indexPath];
        }
        default:
            return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case PDDRBaseInfoRowTypeRadio:
        case PDDRBaseInfoRowTypeWarnbox:
        case PDDRBaseInfoRowTypeHotBed:
        {
            return 60;
        }
        default:
            return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


#pragma mark - Cell Factory

- (UITableViewCell*)p_switchTableCellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath
{
    PDSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDSwitchTableViewCell class]) forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.delegate = self;
    switch (indexPath.row)
    {
        case PDDRBaseInfoRowTypeRadio:
        {
            cell.title = @"辐射台";
            cell.value = _dRecord.radio;
            break;
        }
        case PDDRBaseInfoRowTypeWarnbox:
        {
            cell.title = @"温箱";
            cell.value = _dRecord.warnBox;
            break;
        }
        case PDDRBaseInfoRowTypeLowOxy:
        {
            cell.title = @"低流量吸氧";
            cell.value = _dRecord.lowFlowOxy;
            break;
        }
        case PDDRBaseInfoRowTypeHotBed:
        {
            cell.title = @"温床";
            cell.value = _dRecord.hotBed;
        }
        default:
            break;
    }
    
    return cell;

}

- (UITableViewCell*)p_numberCellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath
{
    PDInputNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDInputNumberTableViewCell class]) forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    cell.indexPath = indexPath;
    cell.delegate = self;
    [cell setTintFontSzie:20 valueSize:18];
    switch (indexPath.row)
    {
        case PDDRBaseInfoRowTypeBodyTem1:
        {
            cell.title = @"体温1";
            cell.unit = @"℃";
            if (_dRecord.bodyTemperature1.length > 0)
            {
                cell.value = _dRecord.bodyTemperature1;
            }
            break;
        }
        case PDDRBaseInfoRowTypeBodyTem2:
        {
            cell.title = @"体温2";
            cell.unit = @"℃";
            if (_dRecord.bodyTemperature2.length > 0)
            {
                cell.value = _dRecord.bodyTemperature2;
            }
            break;
        }
        case PDDRBaseInfoRowTypeBloodOxy1:
        {
            cell.title = @"血氧1";
            cell.unit = @"%";
            if (_dRecord.bloodOxy1.length > 0)
            {
                cell.value = _dRecord.bloodOxy1;
            }
            break;
        }
        case PDDRBaseInfoRowTypeBloodOxy2:
        {
            cell.title = @"血氧2";
            cell.unit = @"%";
            if (_dRecord.bloodOxy2.length > 0)
            {
                cell.value = _dRecord.bloodOxy2;
            }
            break;
        }
        case PDDRBaseInfoRowTypeBreath1:
        {
            cell.title = @"呼吸1";
            cell.unit = @"bpm";
            if (_dRecord.breath1.length > 0)
            {
                cell.value = _dRecord.breath1;
            }
            break;
        }
        case PDDRBaseInfoRowTypeBreath2:
        {
            cell.title = @"呼吸2";
            cell.unit = @"bpm";
            if (_dRecord.breath2.length > 0)
            {
                cell.value = _dRecord.breath2;
            }
            break;
        }
        case PDDRBaseInfoRowTypeHeartRate1:
        {
            cell.title = @"心率1";
            cell.unit = @"bpm";
            if (_dRecord.heartRate1.length > 0)
            {
                cell.value = _dRecord.heartRate1;
            }
            break;
        }
        case PDDRBaseInfoRowTypeHeartRate2:
        {
            cell.title = @"心率2";
            cell.unit = @"bpm";
            if (_dRecord.heartRate2.length > 0)
            {
                cell.value = _dRecord.heartRate2;
            }
            break;
        }
        default:
            break;
    }
    
    return cell;
}


#pragma mark - Cell Delegate Method

- (void)switchCellValueChange:(PDSwitchTableViewCell *)switchCell
{
    switch (switchCell.tag)
    {
        case PDDRBaseInfoRowTypeHotBed:
        {
            _dRecord.hotBed = switchCell.value;
            break;
        }
        case PDDRBaseInfoRowTypeLowOxy:
        {
            _dRecord.lowFlowOxy = switchCell.value;
            break;
        }
        case PDDRBaseInfoRowTypeRadio:
        {
            _dRecord.radio = switchCell.value;
            break;
        }
        case PDDRBaseInfoRowTypeWarnbox:
        {
            _dRecord.warnBox = switchCell.value;
            break;
        }
        default:
            break;
    }
}

- (void)onInputNumberTableViewCellInputFinished:(PDInputNumberTableViewCell *)cell
{
    
    switch (cell.tag)
    {
        case PDDRBaseInfoRowTypeBreath1:
        {
            _dRecord.breath1 = cell.value;
            break;
        }
        case PDDRBaseInfoRowTypeBreath2:
        {
            _dRecord.breath2 = cell.value;
            break;
        }
        case PDDRBaseInfoRowTypeBodyTem1:
        {
            _dRecord.bodyTemperature1 = cell.value;
            break;
        }
        case PDDRBaseInfoRowTypeBodyTem2:
        {
            _dRecord.bodyTemperature2 = cell.value;
            break;
        }
        case PDDRBaseInfoRowTypeHeartRate1:
        {
            _dRecord.heartRate1 = cell.value;
            break;
        }
        case PDDRBaseInfoRowTypeHeartRate2:
        {
            _dRecord.heartRate2 = cell.value;
            break;
        }
        case PDDRBaseInfoRowTypeBloodOxy1:
        {
            _dRecord.bloodOxy1 = cell.value;
            break;
        }
        case PDDRBaseInfoRowTypeBloodOxy2:
        {
            _dRecord.bloodOxy2 = cell.value;
            break;
        }
        default:
            break;
    }
    
    
}

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

@end
