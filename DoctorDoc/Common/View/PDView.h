//
//  PDView.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface PDView : UIView<UIActionSheetDelegate>

- (void)initView;

- (UIActionSheet*)showActionSheet:(NSArray *)values title:(NSString*)title;

- (void)onActionSheet:(UIActionSheet*)sheet selectedAtIndex:(NSUInteger)index;
@end
