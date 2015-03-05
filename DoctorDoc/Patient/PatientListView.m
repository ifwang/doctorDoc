//
//  PatientListView.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PatientListView.h"
#import "PatientTextTableViewCell.h"
#import "PDTableViewHeaderTitle.h"

@interface PatientListView()<UITableViewDataSource,UITableViewDelegate>

/**
 *  病人资料数组
 */
@property (nonatomic, strong) NSMutableArray *listArrary;


@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation PatientListView


- (void)initView
{
    self.listArrary = [[NSMutableArray alloc] init];
    
    [_tableView registerNib:[UINib nibWithNibName:@"PatientTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PatientTextTableViewCell class])];
}

#pragma mark - View Method
- (void)setPatients:(NSArray*)pList
{
    self.listArrary = [NSMutableArray arrayWithArray:pList];
    [_tableView reloadData];
}

- (void)addPatient:(NSDictionary*)pDict
{
    [_listArrary addObject:pDict];
    
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_listArrary.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
}


#pragma mark - TableView Data Source Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArrary count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PatientTextTableViewCell class]) forIndexPath:indexPath];
    
    NSDictionary *pdict = _listArrary[indexPath.row];
    
    cell.title = [NSString stringWithFormat:@"Patient  %@", pdict[@"pid"]];

    cell.detail = pdict[@"date"];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_delegate onDeleteCellAtRow:indexPath.row];
        [_listArrary removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - TableView Delegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [_delegate onSelectCellAtRow:indexPath.row];

}




@end
