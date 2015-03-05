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

@interface PDPatientInfoTableDataSource()

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation PDPatientInfoTableDataSource

- (void)registerTableView:(UITableView *)tableView
{
    self.tableView = tableView;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDInputNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDInputNumberTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDTextViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDTextViewTableViewCell class])];
    
}

#pragma mark - tableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    PDInputNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDInputNumberTableViewCell class]) forIndexPath:indexPath];
    cell.indexPath = indexPath;

    cell.title = @"病人ID";
    cell.value = _pRecord.pid;
    cell.unit = @"";
    cell.inputAble = NO;

    return cell;
}



#pragma mark - Cell Height
- (CGFloat)heightForIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0 )
    {
        return 60;
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
#pragma mark - Private Method
- (void)setPRecord:(PatientRecord *)pRecord
{
    _pRecord = pRecord;
    [_tableView reloadData];
}

- (NSString*)baseInfo
{
    if (_pRecord == nil)
    {
        return @"暂无数据";
    }
    return @"nil";
}

@end
