//
//  NSData+KIZDigest.m
//  KIZCryptorLib
//
//  Created by kingizz on 16/4/15.
//  Copyright © 2016年 kingizz. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "NSData+KIZDigest.h"
#import "NSData+KIZConversion.h"

@implementation NSData (KIZDigest)

- (NSData *)kiz_md2Data{
    return [self digestWithFunction:CC_MD2 length:CC_MD2_DIGEST_LENGTH];
}
- (NSString *)kiz_md2String{
    return [[self digestWithFunction:CC_MD2 length:CC_MD2_DIGEST_LENGTH] kiz_toHexadecimalString];
}

- (NSData *)kiz_md4Data{
    return [self digestWithFunction:CC_MD4 length:CC_MD4_DIGEST_LENGTH];
}
- (NSString *)kiz_md4String{
    return [[self digestWithFunction:CC_MD4 length:CC_MD4_DIGEST_LENGTH] kiz_toHexadecimalString];
}

- (NSData *)kiz_md5Data{
    return [self digestWithFunction:CC_MD5 length:CC_MD5_DIGEST_LENGTH];
}
- (NSString *)kiz_md5String{
    return [[self digestWithFunction:CC_MD5 length:CC_MD5_DIGEST_LENGTH] kiz_toHexadecimalString];
}

- (NSData *)kiz_sha1Data{
    return [self digestWithFunction:CC_SHA1 length:CC_SHA1_DIGEST_LENGTH];
}
- (NSString *)kiz_sha1String{
    return [[self digestWithFunction:CC_SHA1 length:CC_SHA1_DIGEST_LENGTH] kiz_toHexadecimalString];
}


- (NSData *)kiz_sha224Data{
    return [self digestWithFunction:CC_SHA224 length:CC_SHA224_DIGEST_LENGTH];
}
- (NSString *)kiz_sha224String{
    return [[self digestWithFunction:CC_SHA224 length:CC_SHA224_DIGEST_LENGTH] kiz_toHexadecimalString];
}


- (NSData *)kiz_sha256Data{
    return [self digestWithFunction:CC_SHA256 length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)kiz_sha256String{
    return [[self digestWithFunction:CC_SHA256 length:CC_SHA256_DIGEST_LENGTH] kiz_toHexadecimalString];
}


- (NSData *)kiz_sha384Data{
    return [self digestWithFunction:CC_SHA384 length:CC_SHA384_DIGEST_LENGTH];
}
- (NSString *)kiz_sha384String{
    return [[self digestWithFunction:CC_SHA384 length:CC_SHA384_DIGEST_LENGTH] kiz_toHexadecimalString];
}


- (NSData *)kiz_sha512Data{
    return [self digestWithFunction:CC_SHA512 length:CC_SHA512_DIGEST_LENGTH];
}
- (NSString *)kiz_sha512String{
    return [[self digestWithFunction:CC_SHA512 length:CC_SHA512_DIGEST_LENGTH] kiz_toHexadecimalString];
}


- (NSData *)digestWithFunction:(unsigned char *(*)(const void *data, CC_LONG len, unsigned char *md))digestFunction length:(CC_LONG)digestLength{
    
    if (self.length == 0) {
        return nil;
    }
    
    uint8_t     digest[digestLength];
    
    digestFunction(self.bytes, (CC_LONG) self.length, digest);

    NSData *data = [[NSData alloc] initWithBytes:digest length:sizeof(digest)];
    
    return data;
}

@end
