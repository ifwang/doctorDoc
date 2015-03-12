//
//  PDSwitchTableViewCell.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDSwitchTableViewCell.h"

@interface PDSwitchTableViewCell()

@property (nonatomic, weak) IBOutlet UILabel *titleLbl;

@property (nonatomic, weak) IBOutlet UISwitch *swicth;

@end

@implementation PDSwitchTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _titleLbl.font = [UIFont lightFlatFontOfSize:20];
    _swicth.tintColor = HEXCOLOR(0xAE00AE);
    _swicth.onTintColor = HEXCOLOR(0xAE00AE);
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)switchDidChanged:(id)sender
{
    UISwitch *sw = sender;
    
    if (sw.on != _value)
    {
        _value = sw.on;
        [_delegate switchCellValueChange:self];
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLbl.text = _title;
}

- (void)setValue:(BOOL)value
{
    _value = value;
    _swicth.on = value;
}



@end
