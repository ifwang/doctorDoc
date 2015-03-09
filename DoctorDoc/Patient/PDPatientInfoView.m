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
    
    _datasource.delegate = self;
    
}

#pragma mark - view action

- (IBAction)onBaseBtnClicked:(id)sender
{
    [_delegate onBaseInfoBtnClicked];
}


#pragma mark - data source Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == PDPatientInfoTableSectionTypeDialog)
    {
        [_delegate onDialogCellClicked];
    }
    else if (indexPath.section == PDPatientInfoTableSectionTypeAnti)
    {
        [_delegate onAntiCellSelectedAtRow:indexPath.row];
    }
    else if (indexPath.section == PDPatientInfoTableSectionTypePhoto)
    {
        [_delegate onPhotoCellSelectedAtRow:indexPath.row];
    }
    else if (indexPath.section == PDPatientInfoTableSectionTypehypothermia)
    {
        if (indexPath.row == 0)
        {
            [_delegate onHypothermiaCellSelectedAtRow:indexPath.row];
        }
    }
    else if (indexPath.section == PDPatientInfoTableSectionTypeNewBorn)
    {
        [_delegate onNewBornCellSelectAtRow:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView deleteCellforRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == PDPatientInfoTableSectionTypeAnti)
    {
        [_delegate onDeleteAntiCellAtRow:indexPath.row];
    }
    else if (indexPath.section == PDPatientInfoTableSectionTypePhoto)
    {
        [_delegate onDeletePhotoCellAtRow:indexPath.row];
    }
    else if (indexPath.section == PDPatientInfoTableSectionTypehypothermia)
    {
        [_delegate onDeleteHypothermiaCell];
    }
    else if (indexPath.section == PDPatientInfoTableSectionTypeNewBorn)
    {
        [_delegate onDeleteNewbornCell];
    }

}

#pragma mark - Private Method

- (void)setPatientRecord:(PatientRecord *)patientRecord
{
    _patientRecord = patientRecord;
    _datasource.pRecord = patientRecord;
    
    [self setHeaderView:patientRecord];
}

- (void)reload
{
    [_tableView reloadData];
    
    [self setHeaderView:_patientRecord];

}

- (void)setHeaderView:(PatientRecord*)pRecord
{
    _pidLbl.text = pRecord.pid;
    _baseInfoLbl.text = [NSString stringWithFormat:@"体重 %@ kg，头围 %@ cm，身长 %@ cm", pRecord.weight, pRecord.headRound, pRecord.bodyLength];

}


@end
