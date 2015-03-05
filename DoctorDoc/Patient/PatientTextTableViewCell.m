//
//  PatientTextTableViewCell.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PatientTextTableViewCell.h"

@interface PatientTextTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation PatientTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _titleLabel.font = [UIFont lightFlatFontOfSize:24];
    _detailLabel.font = [UIFont lightFlatFontOfSize:18];
    _detailLabel.textColor = HEXCOLOR(0x7B7B7B);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)show
{
    _titleLabel.alpha = 0;
    _detailLabel.alpha = 0;
    
    [UIView animateWithDuration:0.6 animations:^{
        _titleLabel.alpha = 1;
        _detailLabel.alpha = 1;
    }];

}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)setDetail:(NSString *)detail
{
    _detailLabel.text = detail;
}
- (void)setTintFontSzie:(NSUInteger)size detailSize:(NSUInteger)detailSize
{
    _titleLabel.font = [UIFont lightFlatFontOfSize:size];
    _detailLabel.font = [UIFont lightFlatFontOfSize:detailSize];
}


@end
