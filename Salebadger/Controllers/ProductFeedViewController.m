//
//  FirstViewController.m
//  Salebadger
//
//  Created by Lunayo on 08/02/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import "ProductFeedViewController.h"
#import "SBKeychainManager.h"

@interface ProductFeedViewController ()

@end

@implementation ProductFeedViewController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    
    // Override point for customization after application launch.
    // If user is not authenticated
    if (![[SBKeychainManager sharedClient] isUserCredentialExists]) {
        UIViewController* loginViewController = [[UIStoryboard storyboardWithName:@"Main"
                                                                      bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [loginViewController setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:loginViewController animated:NO completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Remove user credential (test)
    [[SBKeychainManager sharedClient] removeSalebadgerUserCredential];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
