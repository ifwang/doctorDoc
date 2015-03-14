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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case PDDRDetailRowTypeFeed:
        {
            return _dRecord.feed == nil?0:1;
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
            
            [cell setTextViewText:[_dRecord.feed feedDescString]];
            
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
            return [PDTextViewTableViewCell cellHeightWithText:[_dRecord.feed feedDescString]];
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
        default:
            break;
    }
    
    return header;
}




@end
