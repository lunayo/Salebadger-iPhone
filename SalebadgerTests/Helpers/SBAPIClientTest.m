//
//  SalebadgerAPIClientTest.m
//  Salebadger
//
//  Created by Lunayo on 03/04/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SBAPIClient.h"

@interface SBAPIClientTest : XCTestCase

@property(nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation SBAPIClientTest

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

- (void)runTestWithBlock:(void (^)(void))block
{
    self.semaphore = dispatch_semaphore_create(0);

    block();

    while (dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];
}

- (void)blockTestCompletedWithBlock:(void (^)(void))block
{
    dispatch_semaphore_signal(self.semaphore);

    if (block) {
        block();
    }
}

- (void)testUserAuthenticationRequestWithValidCredential
{
    // Testing valid username and password
    NSString* username = @"lunayo";
    NSString* password = @"qwertyui";
    __block NSError* errorResult;
    NSURLSessionDataTask* task =
        [[SBAPIClient sharedClient] authenticateUserWithUsername:username
                                                           password:password
                                                              block:^ (NSError * error)
    {
        errorResult = error;
        [self blockTestCompletedWithBlock:^{
                 NSLog(@"Stopping user authentication request");
         }];
    }];
    [self runTestWithBlock:^{
        NSLog(@"Starting user authentication request");
     }];
    XCTAssertNil(errorResult, @"Should return nil");
    int responseCode = [(NSHTTPURLResponse*)[task response] statusCode];
    XCTAssertEqual(responseCode, 204, @"Should return no content response code");
}

- (void)testUserAuthenticationRequestWithInvalidCredential
{
    // Testing valid username and password
    NSString* username = @"lunayo";
    NSString* password = @"random";
    __block NSError* errorResult;
    NSURLSessionDataTask* task =
    [[SBAPIClient sharedClient] authenticateUserWithUsername:username
                                                           password:password
                                                              block:^ (NSError * error)
     {
         errorResult = error;
         [self blockTestCompletedWithBlock:^{
             NSLog(@"Stopping user authentication request");
         }];
     }];
    [self runTestWithBlock:^{
        NSLog(@"Starting user authentication request");
    }];
    XCTAssertNotNil(errorResult, @"Should return error");
    int responseCode = [(NSHTTPURLResponse*)[task response] statusCode];
    XCTAssertEqual(responseCode, 403, @"Should return forbidden response code");
}

@end
