//
//  KIZCryptDigest.m
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "KIZDigestCryptor.h"
#import "NSData+KIZConversion.h"

#define CHUNK_SIZE 1024

@implementation KIZDigestCryptor

+ (NSString *)md5DigestOfString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestedData = [KIZDigestCryptor md5DigestOfData:data];
    
    return [digestedData kiz_toHexadecimalString];
}
+ (NSData *)md5DigestOfData:(NSData *)data{
    
    if (data.length == 0) {
        return nil;
    }
    
    uint8_t     digest[CC_MD5_DIGEST_LENGTH];
    
    // You can ignore the result CC_MD5 because it never fails.
    (void) CC_MD5([data bytes], (CC_LONG) [data length], digest);
    
    return [[NSData alloc] initWithBytes:digest length:sizeof(digest)];
}


+ (NSString*)md5DigestOfFileAtPath:(NSString*)path
{
    NSData *data = [KIZDigestCryptor md5DigestWithFile:path];
    return [data kiz_toHexadecimalString];
}

+ (NSData *)md5DigestWithFile:(NSString *)filePath{
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if( handle== nil ) {
        return nil; // file didnt exist
    }
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: CHUNK_SIZE ];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) {
            done = YES;
        }
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    return [[NSData alloc] initWithBytes:digest length:sizeof(digest)];
}

#pragma mark- SHA1

+ (NSData *)sha1DigestOfData:(NSData *)data{
    
    if (data.length == 0) {
        return nil;
    }
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    // You can ignore the result CC_SHA1 because it never fails.
    (void) CC_SHA1([data bytes], (CC_LONG) data.length, digest);

    return [[NSData alloc] initWithBytes:digest length:sizeof(digest)];
}

+ (NSString *)sha1DigestOfString:(NSString *)string{
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[KIZDigestCryptor sha1DigestOfData:data] kiz_toHexadecimalString];
    
}

+ (NSString *)sha1DigestOfFileAtPath:(NSString *)filePath{
    return [[KIZDigestCryptor sha1DigestDataOfFileAtPath:filePath] kiz_toHexadecimalString];
}

+ (NSData *)sha1DigestDataOfFileAtPath:(NSString *)filePath{
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if( handle== nil ) {
        return nil; // file didnt exist
    }
    
    CC_SHA1_CTX sha1;
    
    CC_SHA1_Init(&sha1);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: CHUNK_SIZE ];
        CC_SHA1_Update(&sha1, [fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) {
            done = YES;
        }
    }
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(digest, &sha1);
    
    return [[NSData alloc] initWithBytes:digest length:sizeof(digest)];
}


#pragma mark-

+ (NSString *)digestString:(NSString *)string withAlgorithm:(KIZDigestAlgorithm)digest{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestedData = [KIZDigestCryptor digestData:data withAlgorithm:digest];
    
    return [digestedData kiz_toHexadecimalString];

}
+ (NSData   *)digestData:(NSData *)data withAlgorithm:(KIZDigestAlgorithm)digestAlgorithm{
    
    if (data.length == 0) {
        return nil;
    }
    
    NSInteger digestLength;
    
    unsigned char *(*MAKE_DIGEST)(const void *data, CC_LONG len, unsigned char *md);
    
    switch (digestAlgorithm) {
        case KIZDigestMD5: {
            digestLength = CC_MD5_DIGEST_LENGTH;
            MAKE_DIGEST = &CC_MD5;
            break;
        }
        case KIZDigestSHA1: {
            digestLength = CC_SHA1_DIGEST_LENGTH;
            MAKE_DIGEST = &CC_SHA1;
            break;
        }
        case KIZDigestSHA224: {
            digestLength = CC_SHA224_DIGEST_LENGTH;
            MAKE_DIGEST = &CC_SHA224;
            break;
        }
        case KIZDigestSHA256: {
            digestLength = CC_SHA256_DIGEST_LENGTH;
            MAKE_DIGEST = &CC_SHA256;
            break;
        }
        case KIZDigestSHA384: {
            digestLength = CC_SHA384_DIGEST_LENGTH;
            MAKE_DIGEST = &CC_SHA384;
            break;
        }
        case KIZDigestSHA512: {
            digestLength = CC_SHA512_DIGEST_LENGTH;
            MAKE_DIGEST = &CC_SHA512;
            break;
        }
    }
    
    uint8_t     digest[digestLength];
    
    // You can ignore the result CC_MD5 because it never fails.
    (void) MAKE_DIGEST([data bytes], (CC_LONG) [data length], digest);
    
    return [[NSData alloc] initWithBytes:digest length:sizeof(digest)];
    
}


@end
