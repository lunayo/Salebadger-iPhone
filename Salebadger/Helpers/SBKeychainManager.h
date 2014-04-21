//
//  KeychainManager.h
//  Salebadger
//
//  Created by Lunayo on 06/04/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBKeychainManager : NSObject

+ (instancetype)sharedClient;
- (void)saveSalebadgerUserCredentialsWithUsername:(NSString*)username
                                         password:(NSString*)password;
- (NSDictionary *)getSalebadgerUserCredential;
- (void)removeSalebadgerUserCredential;
- (BOOL)isUserCredentialExists;

@end
