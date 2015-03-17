//
//  PDInspectViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
@class InspectVO;

@protocol PDInspectViewControllerDelegate;

@interface PDInspectViewController : PDViewController

@property (nonatomic, strong) InspectVO *inspect;

@property (nonatomic, weak) id<PDInspectViewControllerDelegate> delegate;

@end

@protocol PDInspectViewControllerDelegate

- (void)onInspectVCFinishEditing:(PDInspectViewController*)inspectVC;

@end
