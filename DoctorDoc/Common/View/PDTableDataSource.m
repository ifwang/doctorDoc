//
//  PDTableDataSource.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableDataSource.h"

@implementation PDTableDataSource

- (void)registerTableView:(UITableView *)tableView
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)heightForIndexPath:(NSIndexPath*)indexPath
{
    return 0;
}

- (CGFloat)headerHeightForSection:(NSInteger)section
{
    return 0;
}

- (UIView*)headerForSection:(NSInteger)section
{
    return nil;
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

@end
