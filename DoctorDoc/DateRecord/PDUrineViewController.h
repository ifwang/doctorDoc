//
//  PDUrineViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/16.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"

@protocol PDUrineViewControllerDelegate;


@interface PDUrineViewController : PDViewController

@property (nonatomic, copy) NSString *unine;

@property (nonatomic, weak) id<PDUrineViewControllerDelegate> delegate;

@end


@protocol PDUrineViewControllerDelegate

- (void)onUrineVCFinishEditing:(PDUrineViewController*)urineVC;

@end

