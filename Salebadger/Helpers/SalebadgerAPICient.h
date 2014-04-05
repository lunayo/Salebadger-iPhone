//
//  SalebadgerAPICient.h
//  Salebadger
//
//  Created by Lunayo on 27/02/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import "AFNetworking.h"

@interface SalebadgerAPICient : AFHTTPSessionManager

+ (instancetype)sharedClient;
- (NSURLSessionDataTask*)authenticateUserWithUsername:(NSString*)username
                                             password:(NSString*)password
                                                block:(void (^)(NSError* error))block;

@end
