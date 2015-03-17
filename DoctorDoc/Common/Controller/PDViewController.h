//
//  PDViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PDAddVCSourceType)
{
    PDVCSourceTypeAdd = 0,
    PDVCSourceTypeEdit = 1
};

@interface PDViewController : UIViewController

- (void)showTextHUD:(NSString*)text;

- (void)onDone;
- (void)addDoneNaviItem;

@end
