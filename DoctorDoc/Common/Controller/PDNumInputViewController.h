//
//  PDNumInputViewController.h
//  DoctorDoc
//  数字输入页面
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"

@protocol PDNumInputViewControllerDelegate

- (void)onNumInputFinished:(CGFloat)result;

@end

@interface PDNumInputViewController : PDViewController

@property (nonatomic, assign) id<PDNumInputViewControllerDelegate> delegate;

/**
 *  提示文本
 */
@property (nonatomic, copy) NSString *hintText;
/**
 *  数字位数
 */
@property (nonatomic, assign) NSUInteger numCount;
/**
 *  小数点位数
 */
@property (nonatomic, assign) NSUInteger pointIndex;
/**
 *  单位
 */
@property (nonatomic, copy) NSString *unit;

@end
