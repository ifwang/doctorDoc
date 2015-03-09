//
//  PDDateRecordListView.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/10.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDDateRecordListView.h"
#import "PatientTextTableViewCell.h"

@interface PDDateRecordListView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *drList;

@end

@implementation PDDateRecordListView

- (void)initView
{
    
    [_tableView registerNib:[UINib nibWithNibName:@"PatientTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PatientTextTableViewCell class])];
}

- (void)addDateRecord:(NSDictionary*)drDict
{
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_drList.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - TableView Data Source Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _drList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PatientTextTableViewCell class]) forIndexPath:indexPath];
    
    NSDictionary *drDict = _drList[indexPath.row];
    
    cell.title = drDict[@"drid"];
    cell.detail = drDict[@"date"];
    
    return cell;
}


- (void)setDateRecordList:(NSMutableArray*)drList
{
    self.drList = drList;
    
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate onDateRecordCellSelected:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_delegate onDeleteDateRecord:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}






@end
