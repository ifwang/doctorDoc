//
//  PDPatientInfoView.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDPatientInfoView.h"
#import "PDTableViewHeaderTitle.h"
@interface PDPatientInfoView()<PDTableAction>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *pidLbl;

@property (weak, nonatomic) IBOutlet UILabel *baseInfoLbl;

@property (nonatomic, strong) PDPatientInfoTableDataSource *datasource;

@end

@implementation PDPatientInfoView

- (void)initView
{
    self.datasource = [[PDPatientInfoTableDataSource alloc] init];
    [_datasource registerTableView:_tableView];

    _tableView.dataSource = _datasource;
    _tableView.delegate = _datasource;
    [_tableView reloadData];
    
    _pidLbl.font = [UIFont lightFlatFontOfSize:30];
    _baseInfoLbl.font = [UIFont lightFlatFontOfSize:14];
    
}

#pragma mark - view action

- (IBAction)onBaseBtnClicked:(id)sender
{
    [_delegate onBaseInfoBtnClicked];
}


#pragma mark - data source Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Private Method

- (void)setPatientRecord:(PatientRecord *)patientRecord
{
    _patientRecord = patientRecord;
    _datasource.pRecord = patientRecord;
    
    _pidLbl.text = patientRecord.pid;
    _baseInfoLbl.text = [NSString stringWithFormat:@"体重 %@ kg，头围 %@ cm，身长 %@ cm", patientRecord.weight, patientRecord.headRound, patientRecord.bodyLength];
}


@end
