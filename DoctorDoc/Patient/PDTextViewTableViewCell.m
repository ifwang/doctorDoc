//
//  PDTextViewTableViewCell.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTextViewTableViewCell.h"
#import "Masonry.h"

const static CGFloat kCellTextPadding = 20;

@interface PDTextViewTableViewCell()

@property (strong, nonatomic) UILabel *placeholderLabel;

@property (strong, nonatomic) UILabel *label;

@end

@implementation PDTextViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.placeholderLabel = [[UILabel alloc] init];
    _placeholderLabel.font = [UIFont lightFlatFontOfSize:17];
    _placeholderLabel.textColor = HEXCOLOR(0xBEBEBE);
    _placeholderLabel.text = @"请点击输入文本……";
    [self.contentView addSubview:_placeholderLabel];
    
    self.label = [[UILabel alloc] init];
    _label.font = [UIFont lightFlatFontOfSize:17];
    _label.textColor = [UIColor blackColor];
    [self.contentView addSubview:_label];
    _label.numberOfLines = 0;
    UIView *superView = self;
    
    [_label makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(superView.trailing).offset(-kCellTextPadding);
        make.leading.equalTo(superView.leading).offset(kCellTextPadding);
        make.height.equalTo(18);
        make.top.equalTo(superView.top).offset(13);
    }];
    
    [_placeholderLabel makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(superView.leading).offset(kCellTextPadding);
        make.top.equalTo(superView.top).offset(13);
        make.trailing.equalTo(superView.trailing).offset(-kCellTextPadding);
        make.height.equalTo(18);
        
        
    }];

    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTextViewText:(NSString *)cellText
{
    [_label setText:cellText];
    
    if (_label.text.length > 0)
    {
        _placeholderLabel.hidden = YES;
    }
    else
    {
        _placeholderLabel.hidden = NO;
    }
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [self layoutIfNeeded];
    
    
}

- (void)updateConstraints
{
    CGFloat height = [PDTextViewTableViewCell cellHeightWithText:_label.text];
    
    
    UIView *superView = self;
    
    [_label updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(superView.trailing).offset(-kCellTextPadding);
        make.leading.equalTo(superView.leading).offset(kCellTextPadding);
        make.height.equalTo(height>0?height:18);
        make.top.equalTo(superView.top).offset(13);
    }];
    
    [_placeholderLabel updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(superView.leading).offset(kCellTextPadding);
        make.top.equalTo(superView.top).offset(13);
        make.trailing.equalTo(superView.trailing).offset(-kCellTextPadding);
        make.height.equalTo(18);


    }];
    
    [super updateConstraints];
    
}

+ (CGFloat)cellHeightWithText:(NSString*)cellText
{
    CGFloat contentWidth = [UIScreen mainScreen].bounds.size.width - 2 * kCellTextPadding - 70;
    
    CGRect titleRect = [cellText boundingRectWithSize:CGSizeMake(contentWidth, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont lightFlatFontOfSize:17]}
                                              context:nil];

    return titleRect.size.height + 2 * 10;
}



@end
