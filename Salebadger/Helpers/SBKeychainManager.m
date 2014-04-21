//
//  KeychainManager.m
//  Salebadger
//
//  Created by Lunayo on 06/04/2014.
//  Copyright (c) 2014 Codebadge. All rights reserved.
//

#import "SBKeychainManager.h"

static NSString* const kSalebadgerUserCredential = @"SalebadgerUserCredential";

@implementation SBKeychainManager

+ (instancetype)sharedClient
{
    static SBKeychainManager* _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SBKeychainManager alloc] init];
    });

    return _sharedClient;
}

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }

    return self;
}

#pragma mark - User credentials

- (void)saveSalebadgerUserCredentialsWithUsername:(NSString*)username
                                         password:(NSString*)password
{
    NSDictionary *credential = [[NSDictionary alloc] initWithObjectsAndKeys:
                                username, @"username",
                                password, @"password", nil];
    [self save:kSalebadgerUserCredential data:credential];
}

- (NSDictionary *)getSalebadgerUserCredential {
    return [self load:kSalebadgerUserCredential];
}

- (void)removeSalebadgerUserCredential {
    [self delete:kSalebadgerUserCredential];
}

- (BOOL)isUserCredentialExists {
    return ([self load:kSalebadgerUserCredential] != nil);
}

#pragma mark - KeychainManager private method

- (NSMutableDictionary*)getKeychainQuery:(NSString*)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    (__bridge id)kSecClassGenericPassword, (__bridge id)kSecClass,
                                    service, (__bridge id)kSecAttrService,
                                    service, (__bridge id)kSecAttrAccount,
                                    (__bridge id)kSecAttrAccessibleAfterFirstUnlock, (__bridge id)kSecAttrAccessible,
                                    nil];
}

- (void)save:(NSString*)service data:(id)data
{
    NSMutableDictionary* keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data]
                      forKey:(__bridge id)kSecValueData];
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

- (id)load:(NSString*)service
{
    id ret = nil;
    NSMutableDictionary* keychainQuery = [self getKeychainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue
                      forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne
                      forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef*)&keyData) == noErr) {
        @try
        {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData*)keyData];
        }
        @catch (NSException* e)
        {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        }
        @finally
        {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

- (void) delete:(NSString*)service
{
    NSMutableDictionary* keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

@end
