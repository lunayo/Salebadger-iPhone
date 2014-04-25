//
//  SalebadgerAPICient.m
//  Salebadger
//
//  Created by Lunayo on 27/02/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import "SBAPIClient.h"

static NSString* const kSalebadgerAPIBaseURLString =
    @"https://api.codebadge.com/v1/";

@implementation SBAPIClient

+ (instancetype)sharedClient
{
    static SBAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    _sharedClient = [[SBAPIClient alloc]
        initWithBaseURL:[NSURL URLWithString:kSalebadgerAPIBaseURLString]];
    });

    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL*)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [[self responseSerializer] setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    // Remove this code when deploying to production
    [[self securityPolicy] setAllowInvalidCertificates:YES];

    return self;
}

#pragma mark - Salebadger API

- (NSURLSessionDataTask*)authenticateUserWithUsername:(NSString*)username
                                         password:(NSString*)password
                                            block:(void (^)(NSError*))block
{
    [[self requestSerializer] setAuthorizationHeaderFieldWithUsername:username
                                                             password:password];
    return [self GET:@"auth/basic" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // response containts no content
        if (block) {
            block(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(error);
        }
    }];
}

@end
