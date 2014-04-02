//
//  SalebadgerAPICient.m
//  Salebadger
//
//  Created by Lunayo on 27/02/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import "SalebadgerAPICient.h"

static NSString* const kSalebadgerAPIBaseURLString =
    @"https://api.codebadge.com/v1/";

@implementation SalebadgerAPICient

+ (SalebadgerAPICient*)sharedClient
{
    static SalebadgerAPICient* _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    _sharedClient = [[SalebadgerAPICient alloc]
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

    [self setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [self setResponseSerializer:[AFJSONResponseSerializer serializer]];

    return self;
}

#pragma mark - Salebadger API

- (AFHTTPRequestOperation*)authenticateUserWithUsername:(NSString*)username
                                         password:(NSString*)password
                                            block:(void (^)(NSError*))block
{
    [[self requestSerializer] setAuthorizationHeaderFieldWithUsername:username
                                                             password:password];
    return [self GET:@"auth/basic" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // it should return no response
        if (block) {
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(error);
        }
    }];
}

#pragma mark - AFIncrementalStore

@end
