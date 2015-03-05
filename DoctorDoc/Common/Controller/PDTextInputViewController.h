//
//  PDTextInputViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/26.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
@class PDTextInputViewController;
@protocol PDTextInputViewControllerDelegate

- (void)onTextInputFinish:(PDTextInputViewController*)pTextInputVC;

@end

@interface PDTextInputViewController : PDViewController

@property (nonatomic, weak) id<PDTextInputViewControllerDelegate> delegate;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) NSUInteger tag;

@end
