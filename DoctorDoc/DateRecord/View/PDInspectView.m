//
//  PDInspectView.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDInspectView.h"
#import "PDInspectDataSource.h"
@interface PDInspectView()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PDInspectDataSource *datasource;

@end

@implementation PDInspectView

- (void)initView
{
    self.datasource = [[PDInspectDataSource alloc] init];
    _datasource.inspect = _inspect;
    [_datasource registerTableView:_tableView];
}



@end
