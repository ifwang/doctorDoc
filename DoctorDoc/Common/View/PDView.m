//
//  PDView.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDView.h"

@implementation PDView

- (void)initView
{
    
}

- (UIActionSheet*)showActionSheet:(NSArray *)values title:(NSString*)title
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [sheet addButtonWithTitle:obj];
    }];
    
    [sheet showInView:self];
    return sheet;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        return;
    }
    
    [self onActionSheet:actionSheet selectedAtIndex:buttonIndex];
}

- (void)onActionSheet:(UIActionSheet*)sheet selectedAtIndex:(NSUInteger)index
{
    
}


@end
