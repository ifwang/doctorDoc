//
//  PDTableViewHeaderTitle.h
//  DoctorDoc
//  标题Header
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDView.h"

const static CGFloat kPDTableViewHeaderTitleHeight = 50;

@interface PDTableViewHeaderTitle : PDView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *mainColor;

@end
