//
//  PDInputNumberTableViewCell.h
//  DoctorDoc
//  数字输入cell
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PDInputNumberTableViewCell;
@protocol PDInputNumberTableViewCellDelegate

- (void)onInputNumberTableViewCellInputFinished:(PDInputNumberTableViewCell*)cell;

@end

@interface PDInputNumberTableViewCell : UITableViewCell

@property (nonatomic, weak) id<PDInputNumberTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *value;
/**
 *  单位
 */
@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) BOOL inputAble;

@end
