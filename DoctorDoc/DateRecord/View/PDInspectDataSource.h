//
//  PDInspectDataSource.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/17.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableDataSource.h"
#import "InspectVO.h"
@interface PDInspectDataSource : PDTableDataSource

@property (nonatomic, strong) InspectVO *inspect;

@end
