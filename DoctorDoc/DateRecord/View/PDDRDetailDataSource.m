//
//  PDDRDetailDataSource.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDDRDetailDataSource.h"
#import "PatientTextTableViewCell.h"
#import "PDTextViewTableViewCell.h"
#import "PDTableViewHeaderTitle.h"
#import "PatientRecord.h"

@interface PDDRDetailDataSource()

@end


@implementation PDDRDetailDataSource

- (void)registerTableView:(UITableView *)tableView
{
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PatientTextTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PatientTextTableViewCell class])];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDTextViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PDTextViewTableViewCell class])];

    
}

#pragma mark - TableView Datasource Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case PDDRDetailRowTypeFeed:
        {
            return _dRecord.feed == nil?0:1;
        }
        case PDDRDetailRowTypeUrine:
        {
            return _dRecord.urine.length > 0 ? 1:0;
        }
        case PDDRDetailRowTypeStool:
        {
            return _dRecord.stool == nil?0:1;
        }
        case PDDRDetailRowTypeTCB:
        {
            return _dRecord.tcb == nil?0:1;
        }
        case PDDRDetailRowTypeInspect:
        {
            return _dRecord.inspect == nil?0:1;
        }
        default:
            return 0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case PDDRDetailRowTypeFeed:
        {
            PDTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDTextViewTableViewCell class]) forIndexPath:indexPath];
            
            [cell setTextViewText:[_dRecord.feed descString]];
            
            return cell;
        }
        case PDDRDetailRowTypeUrine:
        {
            PDTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDTextViewTableViewCell class]) forIndexPath:indexPath];
            
            
            
            [cell setTextViewText:[self urineString]];
            
            return cell;
        }
        case PDDRDetailRowTypeStool:
        {
            PDTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDTextViewTableViewCell class]) forIndexPath:indexPath];
            
            [cell setTextViewText:[_dRecord.stool descString]];
            
            return cell;
        }
        case PDDRDetailRowTypeTCB:
        {
            PDTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDTextViewTableViewCell class]) forIndexPath:indexPath];
            
            [cell setTextViewText:[_dRecord.tcb descString]];
            
            return cell;
        }
        case PDDRDetailRowTypeInspect:
        {
            PDTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PDTextViewTableViewCell class]) forIndexPath:indexPath];
            
            [cell setTextViewText:[_dRecord.inspect descString]];
            
            return cell;
        }
        default:
            return nil;
    }
}

#pragma mark - TableView Delegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case PDDRDetailRowTypeFeed:
        {
            return [PDTextViewTableViewCell cellHeightWithText:[_dRecord.feed descString]] + 20;
        }
        case PDDRDetailRowTypeUrine:
        {
            return [PDTextViewTableViewCell cellHeightWithText:[self urineString]] + 20;
        }
        case PDDRDetailRowTypeStool:
        {
            return [PDTextViewTableViewCell cellHeightWithText:[_dRecord.stool descString]] + 20;
        }
        case PDDRDetailRowTypeTCB:
        {
            return [PDTextViewTableViewCell cellHeightWithText:[_dRecord.tcb descString]] + 20;
        }
        case PDDRDetailRowTypeInspect:
        {
            return [PDTextViewTableViewCell cellHeightWithText:[_dRecord.inspect descString]] + 20;
        }
        default:
            return 0;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerForSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case PDDRDetailRowTypeFeed:
        {
            return _dRecord.feed == nil?0:kPDTableViewHeaderTitleHeight;
        }
        case PDDRDetailRowTypeUrine:
        {
            return _dRecord.urine.length == 0?0:kPDTableViewHeaderTitleHeight;
        }
        case PDDRDetailRowTypeStool:
        {
            return _dRecord.stool == nil?0:kPDTableViewHeaderTitleHeight;
        }
        case PDDRDetailRowTypeTCB:
        {
            return _dRecord.tcb == nil?0:kPDTableViewHeaderTitleHeight;
        }
        case PDDRDetailRowTypeInspect:
        {
            return _dRecord.inspect == nil?0:kPDTableViewHeaderTitleHeight;
        }
        default:
            return 0;
    }
}

#pragma mark - Header Method

- (UIView*)headerForSection:(NSInteger)section
{
    PDTableViewHeaderTitle *header = [[PDTableViewHeaderTitle alloc] init];
    [header initView];
    
    switch (section)
    {
        case PDDRDetailRowTypeFeed:
        {
            header.title = @"喂养";
            header.mainColor = HEXCOLOR(0x003D79);
            break;
        }
        case PDDRDetailRowTypeUrine:
        {
            header.title = @"尿";
            header.mainColor = HEXCOLOR(0x737300);
            break;
        }
        case PDDRDetailRowTypeStool:
        {
            header.title = @"便便";
            header.mainColor = HEXCOLOR(0x9F5000);
            break;
        }
        case PDDRDetailRowTypeTCB:
        {
            header.title = @"TCB";
            header.mainColor = HEXCOLOR(0x5A5AAD);
            break;
        }
        case PDDRDetailRowTypeInspect:
        {
            header.title = @"送检";
            header.mainColor = HEXCOLOR(0x999777);
            break;
        }
        default:
            break;
    }
    
    return header;
}

#pragma mark - Private Method

- (NSString*)urineString
{
    if (_dRecord.urine.length == 0)
    {
        return nil;
    }
    
    NSMutableString *re = [[NSMutableString alloc] init];
    
    [re appendFormat:@"总量：%@",_dRecord.urine ];
    
    if (_pRecord != nil)
    {
        [re appendFormat:@"，平均：%.2f", _dRecord.urine.doubleValue/_pRecord.weight.doubleValue/24];
    }
    
    return [NSString stringWithString:re];
}


@end
