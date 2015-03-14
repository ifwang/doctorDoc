//
//  PDFeedDataSource.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/14.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTableDataSource.h"
#import "FeedRecordVO.h"

typedef NS_ENUM(NSInteger, PDFeedRowType)
{
    PDFeedRowTypeFeedWay,
    PDFeedRowTypeMilkType,
    PDFeedRowTypeVomit,
    PDFeedRowTypeTotalValue,
    PDFeedRowTypePerDateValue1,
    PDFeedRowTypePerDateValue2,
};


@interface PDFeedDataSource : PDTableDataSource

@property (nonatomic, strong) FeedRecordVO *fRecord;

@end
