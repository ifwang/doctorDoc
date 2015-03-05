//
//  PDNumInputView.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDNumInputView.h"

const static CGFloat kNumLabelWidth = 35;
const static CGFloat KNumLabelHeight = 60;
const static CGFloat kLabelPadding = 10;

@interface PDNumInputView()

@property (nonatomic, assign) NSUInteger numCount;

@property (nonatomic, assign) NSUInteger pointIndex;

@property (nonatomic , strong) UITextField *textField;

@property (nonatomic, strong) NSMutableArray *numbersLabels;

@property (nonatomic, strong) NSMutableArray *numBaseLines;

@end

@implementation PDNumInputView

- (void)initView
{
    self.backgroundColor = [UIColor cloudsColor];
}

- (void)configureNumberOfInput:(NSUInteger)num pointIndex:(NSUInteger)index
{
    _numCount = num;
    _pointIndex = index;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    

    
    
    if (_numbersLabels == nil)
    {
        self.numbersLabels = [[NSMutableArray alloc] init];
    }
    [_numbersLabels removeAllObjects];
    
    if (_numBaseLines == nil)
    {
        self.numBaseLines = [[NSMutableArray alloc] init];
    }
    [_numBaseLines removeAllObjects];
    
    
    
    for (int i = 0; i < num; i ++)
    {
        UILabel *numLbl = [[UILabel alloc] init];
        numLbl.textAlignment = NSTextAlignmentCenter;
        numLbl.backgroundColor = [UIColor clearColor];
        numLbl.font = [UIFont flatFontOfSize:KNumLabelHeight];
        [_numbersLabels addObject:numLbl];
        [self addSubview:numLbl];
        
        UIView *baseLine = [[UIView alloc] init];
        baseLine.backgroundColor = [UIColor blackColor];
        [_numBaseLines addObject:baseLine];
        [self addSubview:baseLine];
    }
    
    CGFloat viewWidth = kNumLabelWidth * num + kLabelPadding * (num - 1);
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(viewWidth);
        make.height.equalTo(KNumLabelHeight + 2);
    }];
    
    UIView *superView = self;
    
    UIView *pointView = nil;
    if (index > 0 && index < num)
    {
        pointView = [[UIView alloc] init];
        pointView.backgroundColor = [UIColor blackColor];
        pointView.layer.cornerRadius = 2;
        [self addSubview:pointView];
    }
    
    for (int i = 0 ; i < num; i ++)
    {
        UIView *label =  _numbersLabels[i];
        UIView *baseLinse = _numBaseLines[i];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView.top).offset(0);
            make.height.equalTo(KNumLabelHeight);
            make.width.equalTo(kNumLabelWidth);
        }];
        
        if (i == 0)
        {
            [label makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(superView.left);
            }];
        }
        else if (i == (num - 1))
        {
            [label makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(superView.right);
            }];
        }
        else
        {
            UIView *preLabel = _numbersLabels[i - 1];
            [label makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preLabel.right).offset(kLabelPadding);
            }];
        }
        
        [baseLinse makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.bottom);
            make.height.equalTo(2);
            make.width.equalTo(kNumLabelWidth);
            make.left.equalTo(label.left);
        }];
        
        if (i == index)
        {
            [pointView makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(baseLinse.bottom);
                make.height.equalTo(4);
                make.width.equalTo(4);
                make.centerX.equalTo(baseLinse.left).offset(-5);
            }];
        }
        
    }
    
    self.textField = [[UITextField alloc] initWithFrame:self.bounds];
    _textField.hidden = YES;
    [self addSubview:_textField];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [_textField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:_textField];
    
}

#pragma mark - TextField Delegate
- (void)textFieldChanged:(NSNotification*)notification
{
    [self reset];
    
    NSString *text = _textField.text;
    
    if (text.length < _numCount)
    {
        for (int i = 0; i < text.length; i ++)
        {
            NSRange range;
            range.location = i;
            range.length = 1;
            NSString *subStr = [text substringWithRange:range];
            UILabel *label = _numbersLabels[i];
            label.text = subStr;
            UIView *line = _numBaseLines[i];
            line.hidden = YES;
        }
    }
    
    if (text.length >= _numCount)
    {
        NSRange range;
        range.location = 0;
        range.length = _numCount;
        
        if (_delegate != nil)
        {
            [_delegate numberInputFinish:[text substringWithRange:range]];
        }
        _textField.text = @"";
    }
}

- (void)reset
{
    [_numbersLabels makeObjectsPerformSelector:@selector(setText:) withObject:@""];
    for (UIView *line in _numBaseLines)
    {
        line.hidden = NO;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
