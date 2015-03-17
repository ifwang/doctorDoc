//
//  PDStoolView.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/16.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDStoolView.h"
#import "PDStoolDataSource.h"

@interface PDStoolView()<PDTableAction>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PDStoolDataSource *datasource;

@end

@implementation PDStoolView

- (void)initView
{
    self.datasource = [[PDStoolDataSource alloc] init];
    _datasource.stoolVO = _stool;
    _datasource.delegate = self;
    [_datasource registerTableView:_tableView];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showActionSheet:[StoolVO stoolColorList] title:@"选择颜色"];
}

- (void)onActionSheet:(UIActionSheet *)sheet selectedAtIndex:(NSUInteger)index
{
    NSString *value = [StoolVO stoolColorList][index - 1];
    
    _stool.stoolColor = value;
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}



@end
