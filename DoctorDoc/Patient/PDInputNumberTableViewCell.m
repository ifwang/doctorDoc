//
//  PDInputNumberTableViewCell.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDInputNumberTableViewCell.h"

@interface PDInputNumberTableViewCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@end

@implementation PDInputNumberTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _titleLabel.font = [UIFont lightFlatFontOfSize:24];
    _textField.font = [UIFont lightFlatFontOfSize:21];
    _unitLabel.font = [UIFont lightFlatFontOfSize:18];
    _textField.delegate = self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:_textField];
}

- (void)setInputAble:(BOOL)inputAble
{
    _inputAble = inputAble;
    _textField.userInteractionEnabled = _inputAble;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - Setter Method
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

- (void)setValue:(NSString *)value
{
    _value = value;
    _textField.text = value;
}

- (void)setUnit:(NSString *)unit
{
    _unit = unit;
    _unitLabel.text = unit;
}

- (void)textDidChanged:(NSNotification*)notification
{
    _value = _textField.text;

    [_delegate onInputNumberTableViewCellInputFinished:self];
    
}

- (void)setTintFontSzie:(NSUInteger)size valueSize:(NSUInteger)valueSize;
{
    _titleLabel.font = [UIFont lightFlatFontOfSize:size];
    _textField.font = [UIFont lightFlatFontOfSize:valueSize];
    _unitLabel.font = [UIFont lightFlatFontOfSize:valueSize-3];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(onTextFieldBeginEditing:)])
    {
        [_delegate onTextFieldBeginEditing:self];
    }
}


@end
