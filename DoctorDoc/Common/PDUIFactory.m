//
//  PDUIFactory.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/3.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDUIFactory.h"

@implementation PDUIFactory

+(FUIButton*)doneButton
{
    FUIButton *button = [[FUIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    button.buttonColor = HEXCOLOR(0x019858);
    button.highlightedColor = HEXCOLOR(0x003E3E);
    button.shadowColor = HEXCOLOR(0x3C3C3C);
    button.shadowHeight = 2;
    button.cornerRadius = 4;
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont lightFlatFontOfSize:16];
    
    return button;
}

@end
