//
//  PDTCBDataSource.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableDataSource.h"
#import "TCBVO.h"

@interface PDTCBDataSource : PDTableDataSource

@property (nonatomic, strong) TCBVO *tcb;

@end
