//
//  PatientTextTableViewCell.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientTextTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *detail;



- (void)show;

- (void)setTintFontSzie:(NSUInteger)size detailSize:(NSUInteger)detailSize;

@end
