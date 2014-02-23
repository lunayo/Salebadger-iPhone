//
//  LoginViewController.h
//  Salebadger
//
//  Created by Lunayo on 10/02/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginButtonDidTap:(id)sender;
- (IBAction)registerButtonDidTap:(id)sender;

@end
