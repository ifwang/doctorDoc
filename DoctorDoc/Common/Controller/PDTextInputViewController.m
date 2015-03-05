//
//  PDTextInputViewController.m
//  DoctorDoc
//
//  Created by ifwang on 15/2/26.
//  Copyright (c) 2015年 ifwang. All rights reserved.
//

#import "PDTextInputViewController.h"
#import "PDUIFactory.h"

@interface PDTextInputViewController ()<UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation PDTextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initBarItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    _textView.font = [UIFont lightFlatFontOfSize:15];
    _textView.text = _text;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textViewDidFinishEdit:(id)sender
{
    if (_textView.text.length == 0)
    {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"文本不能为空";
        [hud hide:YES afterDelay:1];
        return;
    }
    _text = _textView.text;
    [self.navigationController popViewControllerAnimated:YES];
    [_delegate onTextInputFinish:self];
}

#pragma mark - Text View Delegate

#pragma mark - Private Method

- (void)initBarItem
{
    FUIButton *button = [PDUIFactory doneButton];

    [button addTarget:self action:@selector(textViewDidFinishEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;

}


- (void) keyboardWasShown:(NSNotification *) notif
{
//    NSDictionary *info = [notif userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
//    
//    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
}


@end
