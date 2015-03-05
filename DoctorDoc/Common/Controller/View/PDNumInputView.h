//
//  PDNumInputView.h
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDView.h"

@protocol PDNumInputViewDelegate

- (void)numberInputFinish:(NSString*)result;

@end

@interface PDNumInputView : PDView

@property (nonatomic, weak) id<PDNumInputViewDelegate> delegate;

- (void)configureNumberOfInput:(NSUInteger)num pointIndex:(NSUInteger)index;

- (void)reset;

@end
