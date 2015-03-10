//
//  PDDateRecordDetailView.m
//  DoctorDoc
//
//  Created by ifwang on 15/3/11.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDDateRecordDetailView.h"
#import "PDDRDetailDataSource.h"

@interface PDDateRecordDetailView()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UILabel *dridLbl;

@property (nonatomic, weak) IBOutlet UILabel *baseInfoLbl;

@property (nonatomic, strong) PDDRDetailDataSource *datasource;

@end

@implementation PDDateRecordDetailView

- (void)initView
{
    
}

#pragma mark - Private Method

- (void)reload
{
    _dridLbl.text = _drKey;
    _baseInfoLbl.text = [self baseInfoString];
}

- (NSString*)baseInfoString
{
    if (_dRecord == nil)
    {
        return @"暂无数据";
    }
    
    NSMutableString *baseStr = [[NSMutableString alloc] init];
    
    if (_dRecord.radio)
    {
        [baseStr appendString:@"辐射台，"];
    }
    if (_dRecord.warnBox)
    {
        [baseStr appendString:@"温箱，"];
    }
    if (_dRecord.hotBed)
    {
        [baseStr appendString:@"温床，"];
    }
    if (_dRecord.bodyTemperature.length > 0)
    {
        [baseStr appendFormat:@"体温: %@ ℃，", _dRecord.bodyTemperature];
    }
    if (_dRecord.heartRate.length > 0)
    {
        [baseStr appendFormat:@"心率: %@ 次/分，",_dRecord.heartRate ];
    }
    if (_dRecord.breath.length > 0)
    {
        [baseStr appendFormat:@"呼吸: %@ 次/分，",_dRecord.breath ];
    }
    if (_dRecord.lowFlowOxy)
    {
        [baseStr appendString:@"低流量吸氧，"];
    }
    if (_dRecord.bloodOxy.length > 0)
    {
        [baseStr appendFormat:@"血氧: %@，", _dRecord.bloodOxy];
    }
    
    if (baseStr.length > 0)
    {
        NSString *re = [baseStr substringToIndex:baseStr.length - 1];
        return re;
    }
    else
    {
        return @"";
    }
}


@end
