//
//  KIZRSASHAVerify.m
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "KIZRSAVerify.h"

@interface KIZRSAVerify ()

@property (nonatomic, assign) SecKeyRef publicKey;

@end

@implementation KIZRSAVerify

- (instancetype)initWithPublicKey:(SecKeyRef)publicKey{
    self = [super init];
    if (self) {
        _publicKey = publicKey;
    }
    return self;
}

- (BOOL)verifyPlainData:(NSData *)plainData signatureData:(NSData *)signatureData withDigest:(KIZRSASignDigest)digest{
    
    SecPadding padding;
    size_t     signedDataLength;
    
    unsigned char (*RSA_Digest_Cast)(const void *data, CC_LONG len, unsigned char *md);
    
    switch (digest) {
        case KIZRSASignSHA1: {
            padding          = kSecPaddingPKCS1SHA1;
            signedDataLength = CC_SHA1_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA1;
            break;
        }
        case KIZRSASignSHA224: {
            padding          = kSecPaddingPKCS1SHA224;
            signedDataLength = CC_SHA224_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA224;
            break;
        }
        case KIZRSASignSHA256: {
            padding          = kSecPaddingPKCS1SHA256;
            signedDataLength = CC_SHA256_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA256;
            break;
        }
        case KIZRSASignSHA384: {
            padding          = kSecPaddingPKCS1SHA384;
            signedDataLength = CC_SHA384_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA384;
            break;
        }
        case KIZRSASignSHA512: {
            padding          = kSecPaddingPKCS1SHA512;
            signedDataLength = CC_SHA512_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA512;
            break;
        }
        case KIZRSASignMD2: {
            padding          = kSecPaddingPKCS1MD2;
            signedDataLength = CC_MD2_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_MD2;
            break;
        }
        case KIZRSASignMD5: {
            padding          = kSecPaddingPKCS1MD5;
            signedDataLength = CC_MD5_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_MD5;
            break;
        }
    }
    
    uint8_t *signedData = malloc(signedDataLength);
    
    if (!RSA_Digest_Cast(plainData.bytes, (CC_LONG)plainData.length, signedData)) {
        return NO;
    }
    
    OSStatus status = SecKeyRawVerify(
                                      self.publicKey,
                                      padding,
                                      signedData,
                                      signedDataLength,
                                      signatureData.bytes,
                                      SecKeyGetBlockSize(self.publicKey)
                                      );
    
    return status == errSecSuccess;
}

@end
