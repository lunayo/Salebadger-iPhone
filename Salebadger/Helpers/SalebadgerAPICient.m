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

- (id)initWithBaseURL:(NSURL*)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    [self setResponseSerializer:[AFJSONResponseSerializer serializer]];

    return self;
}

#pragma mark - AFIncrementalStore

@end
