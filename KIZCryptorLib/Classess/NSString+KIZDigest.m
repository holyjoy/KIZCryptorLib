//
//  NSString+KIZDigest.m
//  KIZCryptorLib
//
//  Created by kingizz on 16/4/15.
//  Copyright © 2016年 kingizz. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "NSString+KIZDigest.h"
#import "NSData+KIZDigest.h"
#import "NSData+KIZConversion.h"

#define DigestString(_digest) [[self dataUsingEncoding:NSUTF8StringEncoding] _digest]

static const NSUInteger CHUNK_SIZE = 1024;

@implementation NSString (KIZDigest)

+ (instancetype)kiz_md2StringWithContentOfFile:(NSString *)path{
    
    CC_MD2_CTX context;
    return [[NSString kiz_digestDataWithContentOfPath:path
                                       digestContext:&context
                                        initFunction:(void *)CC_MD2_Init
                                      updateFunction:(void *)CC_MD2_Update
                                       finalFunction:(void *)CC_MD2_Final
            ] kiz_toHexadecimalString];
}

+ (instancetype)kiz_md4StringWithContentOfFile:(NSString *)path{
    
    CC_MD4_CTX context;
    return [[NSString kiz_digestDataWithContentOfPath:path
                                        digestContext:&context
                                         initFunction:(void *)CC_MD4_Init
                                       updateFunction:(void *)CC_MD4_Update
                                        finalFunction:(void *)CC_MD4_Final
             ] kiz_toHexadecimalString];
}

+ (instancetype)kiz_md5StringWithContentOfFile:(NSString *)path{
    
    CC_MD5_CTX context;
    return [[NSString kiz_digestDataWithContentOfPath:path
                                        digestContext:&context
                                         initFunction:(void *)CC_MD5_Init
                                       updateFunction:(void *)CC_MD5_Update
                                        finalFunction:(void *)CC_MD5_Final
             ] kiz_toHexadecimalString];
}

+ (instancetype)kiz_sha1StringWithContentOfFile:(NSString *)path{
    
    CC_SHA1_CTX context;
    return [[NSString kiz_digestDataWithContentOfPath:path
                                        digestContext:&context
                                         initFunction:(void *)CC_SHA1_Init
                                       updateFunction:(void *)CC_SHA1_Update
                                        finalFunction:(void *)CC_SHA1_Final
             ] kiz_toHexadecimalString];
}

+ (instancetype)kiz_sha224StringWithContentOfFile:(NSString *)path{
    
    CC_SHA256_CTX context;
    return [[NSString kiz_digestDataWithContentOfPath:path
                                        digestContext:&context
                                         initFunction:(void *)CC_SHA224_Init
                                       updateFunction:(void *)CC_SHA224_Update
                                        finalFunction:(void *)CC_SHA224_Final
             ] kiz_toHexadecimalString];
}

+ (instancetype)kiz_sha256StringWithContentOfFile:(NSString *)path{
    
    CC_SHA256_CTX context;
    return [[NSString kiz_digestDataWithContentOfPath:path
                                        digestContext:&context
                                         initFunction:(void *)CC_SHA256_Init
                                       updateFunction:(void *)CC_SHA256_Update
                                        finalFunction:(void *)CC_SHA256_Final
             ] kiz_toHexadecimalString];
}

+ (instancetype)kiz_sha384StringWithContentOfFile:(NSString *)path{
    
    CC_SHA512_CTX context;
    return [[NSString kiz_digestDataWithContentOfPath:path
                                        digestContext:&context
                                         initFunction:(void *)CC_SHA384_Init
                                       updateFunction:(void *)CC_SHA384_Update
                                        finalFunction:(void *)CC_SHA384_Final
             ] kiz_toHexadecimalString];
}

+ (instancetype)kiz_sha512StringWithContentOfFile:(NSString *)path{
    
    CC_SHA512_CTX context;
    return [[NSString kiz_digestDataWithContentOfPath:path
                                        digestContext:&context
                                         initFunction:(void *)CC_SHA512_Init
                                       updateFunction:(void *)CC_SHA512_Update
                                        finalFunction:(void *)CC_SHA512_Final
             ] kiz_toHexadecimalString];
}

+ (NSData *)kiz_digestDataWithContentOfPath:(NSString *)path
                              digestContext:(void *)context
                               initFunction:(int *(void *))initFunction
                             updateFunction:(int *(void *, const void *, CC_LONG ))updateFunction
                              finalFunction:(int *(unsigned char *, void *))finalFunction{
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) {
        return nil; // file didnt exist
    }
    
    initFunction(context);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: CHUNK_SIZE ];
        updateFunction(context, [fileData bytes], (CC_LONG)[fileData length]);
        if( fileData.length == 0 ) {
            done = YES;
        }
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    finalFunction(digest, context);
    
    return [[NSData alloc] initWithBytes:digest length:sizeof(digest)];
}

#pragma mark-
- (NSString *)kiz_md2String{
    return DigestString(kiz_md2String);
}

- (NSString *)kiz_md4String{
    return DigestString(kiz_md4String);
}

- (NSString *)kiz_md5String{
    return DigestString(kiz_md5String);
}


#pragma mark-
- (NSString *)kiz_sha1String{
    return DigestString(kiz_sha1String);
}

- (NSString *)kiz_sha224String{
    return DigestString(kiz_sha224String);
}


- (NSString *)kiz_sha256String{
    return DigestString(kiz_sha256String);
}

- (NSString *)kiz_sha384String{
    return DigestString(kiz_sha384String);
}

- (NSString *)kiz_sha512String{
    return DigestString(kiz_sha512String);
}

@end
