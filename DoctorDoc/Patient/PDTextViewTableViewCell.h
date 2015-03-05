//
//  PDTextViewTableViewCell.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDTextViewTableViewCell : UITableViewCell

- (void)setTextViewText:(NSString *)cellText;

+ (CGFloat)cellHeightWithText:(NSString*)cellText;

@end
