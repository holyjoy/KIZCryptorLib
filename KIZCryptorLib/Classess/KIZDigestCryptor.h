//
//  KIZCryptDigest.h
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIZDigestCryptor : NSObject

#pragma mark- MD5
+ (NSString *)md5DigestOfString:(NSString *)string;
+ (NSData   *)md5DigestOfData:(NSData *)data;
+ (NSString *)md5DigestOfFileAtPath:(NSString*)filePath;

#pragma mark- SHA1
+ (NSString *)sha1DigestOfString:(NSString *)string;
+ (NSData   *)sha1DigestOfData:(NSData *)data;
+ (NSString *)sha1DigestOfFileAtPath:(NSString *)filePath;

@end
