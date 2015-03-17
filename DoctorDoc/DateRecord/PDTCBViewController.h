//
//  PDTCBViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
@class TCBVO;
@protocol PDTCBViewControllerDelegate;

@interface PDTCBViewController : PDViewController

@property (nonatomic, strong) TCBVO *tcbVO;

@property (nonatomic, weak) id<PDTCBViewControllerDelegate> delegate;

@end

@protocol PDTCBViewControllerDelegate

- (void)onTCBVCFinishEditing:(PDTCBViewController*)tcbVC;

@end