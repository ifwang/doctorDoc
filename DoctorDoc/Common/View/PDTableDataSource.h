//
//  PDTableDataSource.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDViewController.h"

@protocol PDTableAction

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (void)tableView:(UITableView *)tableView  deleteCellforRowAtIndexPath:(NSIndexPath *)indexPath;


@end


@interface PDTableDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id<PDTableAction> delegate;

- (void)registerTableView:(UITableView*)tableView;

@end
