//
//  AntibioticsViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/5.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
#import "AntibioticsVO.h"
@class AntibioticsViewController;

@protocol AntibioticsViewControllerDelegate

- (void)AntibioticsViewControllerDidFinishEdit:(AntibioticsViewController*)antiVC;

@end

@interface AntibioticsViewController : PDViewController

@property (nonatomic, assign) PDAddVCSourceType sourceType;

@property (nonatomic, strong) AntibioticsVO *antiVO;

@property (nonatomic, weak) id<AntibioticsViewControllerDelegate> delegate;

@end
