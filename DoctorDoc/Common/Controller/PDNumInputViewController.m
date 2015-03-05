//
//  PDNumInputViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/8.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDNumInputViewController.h"
#import "PDNumInputView.h"
@interface PDNumInputViewController ()<UITextFieldDelegate,PDNumInputViewDelegate>

@property (nonatomic, strong) PDNumInputView *iView;

@property (nonatomic, weak) IBOutlet UILabel *hintLbl;

@end

@implementation PDNumInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _hintLbl.font = [UIFont lightFlatFontOfSize:18];
    NSMutableString *hintText = [[NSMutableString alloc] init];
    if (_hintText != nil)
    {
        [hintText appendString:_hintText];
    }
    
    if (_unit != nil)
    {
        [hintText appendFormat:@"(%@)",_unit];
    }
    _hintLbl.text = hintText;
    
    
    PDNumInputView *inputView = [[PDNumInputView alloc] init];
    [self.view addSubview:inputView];
    inputView.delegate = self;
    [inputView configureNumberOfInput:_numCount pointIndex:_pointIndex];
    self.iView = inputView;
    
    UIView *superView = self.view;
    [inputView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView.centerY).offset(-100);
        make.centerX.equalTo(superView.centerX);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)numberInputFinish:(NSString *)result
{
    NSUInteger reNum = [result integerValue];
    
    double pIndex = 1;
    for (int i = 0; i < (_numCount - _pointIndex); i ++)
    {
        pIndex *= 0.1;
    }
    
    CGFloat tReslut = reNum * pIndex;
    NSLog(@"re : %f", tReslut);
    
    
    [_delegate onNumInputFinished:tReslut];
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
