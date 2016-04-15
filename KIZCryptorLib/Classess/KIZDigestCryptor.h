//
//  KIZCryptDigest.h
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KIZDigestAlgorithm) {
    KIZDigestMD5,
    KIZDigestSHA1,
    KIZDigestSHA224,
    KIZDigestSHA256,
    KIZDigestSHA384,
    KIZDigestSHA512
};

@interface KIZDigestCryptor : NSObject

#pragma mark- MD5
+ (NSString *)md5DigestOfString:(NSString *)string;
+ (NSData   *)md5DigestOfData:(NSData *)data;
+ (NSString *)md5DigestOfFileAtPath:(NSString*)filePath;

#pragma mark- SHA1
+ (NSString *)sha1DigestOfString:(NSString *)string;
+ (NSData   *)sha1DigestOfData:(NSData *)data;
+ (NSString *)sha1DigestOfFileAtPath:(NSString *)filePath;

#pragma mark-

+ (NSString *)digestString:(NSString *)string withAlgorithm:(KIZDigestAlgorithm)digest;
+ (NSData   *)digestData:(NSData *)data withAlgorithm:(KIZDigestAlgorithm)digest;

@end
