//
//  PDSwitchTableViewCell.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDSwitchTableViewCellDelegate;

@interface PDSwitchTableViewCell : UITableViewCell

@property (nonatomic,weak) id<PDSwitchTableViewCellDelegate> delegate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL value;

@end

@protocol PDSwitchTableViewCellDelegate

- (void)switchCellValueChange:(PDSwitchTableViewCell*)switchCell;

@end