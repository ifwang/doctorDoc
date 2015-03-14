//
//  PDFeedViewController.h
//  DoctorDoc
//
//  Created by ifwang on 15/3/14.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDViewController.h"
#import "FeedRecordVO.h"

@protocol PDFeedViewControllerDelegate;


@interface PDFeedViewController : PDViewController

@property (nonatomic, strong) FeedRecordVO *feedRecord;

@property (nonatomic, weak) id<PDFeedViewControllerDelegate> delegate;

@end

@protocol PDFeedViewControllerDelegate

- (void)onFeedFinishedEditing:(PDFeedViewController*)feedVC;

@end
