//
//  SBKeychainManagerTest.m
//  Salebadger
//
//  Created by Lunayo on 21/04/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SBKeychainManager.h"

@interface SBKeychainManagerTest : XCTestCase

@end

@implementation SBKeychainManagerTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testSaveUserCredentialToKeychain
{
    NSString* username = @"lunayo";
    NSString* password = @"password";

    [[SBKeychainManager sharedClient] removeSalebadgerUserCredential];
    [[SBKeychainManager sharedClient] saveSalebadgerUserCredentialsWithUsername:username
                                                                       password:password];
    NSDictionary *credential = [[SBKeychainManager sharedClient] getSalebadgerUserCredential];
    
    XCTAssertTrue([[credential valueForKey:@"username"] isEqualToString:username], @"Username should be matched");
    XCTAssertTrue([[credential valueForKey:@"password"] isEqualToString:password], @"Password should be matched");
    
    [[SBKeychainManager sharedClient] removeSalebadgerUserCredential];
}

@end
