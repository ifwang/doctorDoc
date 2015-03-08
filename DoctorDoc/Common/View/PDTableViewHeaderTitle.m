//
//  PDTableViewHeaderTitle.m
//  DoctorDoc
//  标题Header
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableViewHeaderTitle.h"

@interface PDTableViewHeaderTitle()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *line;

@end

@implementation PDTableViewHeaderTitle

- (void)initView
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont lightFlatFontOfSize:20];
    [self addSubview:_titleLabel];
    
    self.line = [[UIView alloc] init];
    [self addSubview:_line];
    
    UIView *superView = self;
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(20);
        make.bottom.equalTo(superView.bottom).offset(-10);
        make.height.equalTo(26);
        make.width.equalTo(200);
    }];
    
    [_line makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(superView.width);
        make.bottom.equalTo(superView.bottom);
        make.height.equalTo(2);
        make.left.equalTo(superView.left);
    }];
    
}

- (void)setMainColor:(UIColor *)mainColor
{
    _titleLabel.textColor = mainColor;
    _line.backgroundColor = mainColor;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

@end
