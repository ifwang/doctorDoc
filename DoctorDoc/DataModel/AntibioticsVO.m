//
//  AntibioticsVO.m
//  DoctorDoc
//  抗生素
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "AntibioticsVO.h"

@implementation AntibioticsVO

+ (instancetype)mockVO
{
    AntibioticsVO *mockVO = [[AntibioticsVO alloc] init];
    
    mockVO.date = [NSDate date];
    mockVO.text = @"抗生素1111";
    
    
    return mockVO;
}

@end
