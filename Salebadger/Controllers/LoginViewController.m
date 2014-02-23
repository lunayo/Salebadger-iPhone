//
//  LoginViewController.m
//  Salebadger
//
//  Created by Lunayo on 10/02/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Private Method
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - UIKeyboard Notifications
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGRect kbRect = [self.view convertRect:[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue] fromView:nil];
    CGSize kbSize = kbRect.size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    [_scrollView setContentInset:contentInsets];
    [_scrollView setScrollIndicatorInsets:contentInsets];
    [_scrollView scrollRectToVisible:[_loginButton frame] animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillHide:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    [_scrollView setContentInset:contentInsets];
    [_scrollView setScrollIndicatorInsets:contentInsets];
}

#pragma mark - UIView User Interaction
- (IBAction)contentViewShouldReceiveToTouch:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

#pragma mark - UIView Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Handlers

- (IBAction)loginButtonDidTap:(id)sender {
}

- (IBAction)registerButtonDidTap:(id)sender {
}
@end
