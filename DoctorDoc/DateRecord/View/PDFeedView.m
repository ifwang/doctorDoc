//
//  PDFeedView.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/14.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDFeedView.h"
#import "PDFeedDataSource.h"
#import "FeedRecordVO.h"
@interface PDFeedView()<PDTableAction, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PDFeedDataSource *dataSource;

@end

@implementation PDFeedView

- (void)initView
{
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 218, 0)];

    self.dataSource = [[PDFeedDataSource alloc] init];
    _dataSource.fRecord = _fRecord;
    _dataSource.delegate = self;
    [_dataSource registerTableView:_tableView];
    
}

- (void)setFRecord:(FeedRecordVO *)fRecord
{
    _fRecord = fRecord;
    _dataSource.fRecord = fRecord;
    [_tableView reloadData];
}

- (void)reload
{
    [_tableView reloadData];
}


#pragma mark - Data Source Delegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *valueArray = nil;
    NSString *title = nil;
    
    if (indexPath.row == PDFeedRowTypeFeedWay)
    {
        valueArray = [FeedRecordVO feedTypeList];
        title = @"喂养";
    }
    else
    {
        valueArray = [FeedRecordVO milkTypeList];
        title = @"喂奶";
    }
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    sheet.tag = indexPath.row;
    
    [valueArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [sheet addButtonWithTitle:obj];
    }];
    
    [sheet showInView:self];
}

#pragma mark - Action Sheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        return;
    }
    NSInteger row = buttonIndex - 1;

    if (actionSheet.tag == PDFeedRowTypeFeedWay)
    {
        
        NSString *value = [FeedRecordVO feedTypeList][row];
        _fRecord.feedWay = value;
        
    }
    else if (actionSheet.tag == PDFeedRowTypeMilkType)
    {
        NSString *value = [FeedRecordVO milkTypeList][row];
        _fRecord.milkType = value;
    }
    
    
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:actionSheet.tag inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

}


@end
