//
//  PDStoolViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/16.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
#import "StoolVO.h"

@protocol PDStoolViewControllerDelegate;

@interface PDStoolViewController : PDViewController

@property (nonatomic, strong) StoolVO *stool;

@property (nonatomic, weak) id<PDStoolViewControllerDelegate> delegate;

@end

@protocol PDStoolViewControllerDelegate

- (void)onStoolVCFinishEditing:(PDStoolViewController*)stoolVC;

@end
