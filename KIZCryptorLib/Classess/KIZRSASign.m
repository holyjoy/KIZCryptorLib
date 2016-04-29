//
//  KIZRSASHASign.m
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "KIZRSASign.h"

@interface KIZRSASign ()

@property (nonatomic, assign) SecKeyRef privateKey;

@end

@implementation KIZRSASign

- (instancetype)initWithPrivateKey:(SecKeyRef)privateKey{
    self = [super init];
    if (self) {
        _privateKey = privateKey;
    }
    return self;
}

/**
 *  sign the string
 *
 *  @param string
 *  @param digest
 *
 *  @return signed string with base64 encoded
 */
- (NSString *)signString:(NSString *)string withDigest:(KIZRSASignDigest)digest{
    NSData *dataSoSign = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *signedData = [self signData:dataSoSign WithDigest:digest];

    return [signedData base64EncodedStringWithOptions:0];
}

- (NSData *)signData:(NSData *)data WithDigest:(KIZRSASignDigest)digest{
    
    SecPadding  padding;
    size_t      dataToSignLength;
    
    unsigned char (*RSA_Digest_Cast)(const void *data, CC_LONG len, unsigned char *md);
    
    switch (digest) {
        case KIZRSASignSHA1: {
            padding          = kSecPaddingPKCS1SHA1;
            dataToSignLength = CC_SHA1_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA1;
            break;
        }
        case KIZRSASignSHA224: {
            padding          = kSecPaddingPKCS1SHA224;
            dataToSignLength = CC_SHA224_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA224;
            break;
        }
        case KIZRSASignSHA256: {
            padding          = kSecPaddingPKCS1SHA256;
            dataToSignLength = CC_SHA256_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA256;
            break;
        }
        case KIZRSASignSHA384: {
            padding          = kSecPaddingPKCS1SHA384;
            dataToSignLength = CC_SHA384_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA384;
            break;
        }
        case KIZRSASignSHA512: {
            padding          = kSecPaddingPKCS1SHA512;
            dataToSignLength = CC_SHA512_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_SHA512;
            break;
        }
        case KIZRSASignMD2: {
            padding          = kSecPaddingPKCS1MD2;
            dataToSignLength = CC_MD2_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_MD2;
            break;
        }
        case KIZRSASignMD5: {
            padding          = kSecPaddingPKCS1MD5;
            dataToSignLength = CC_MD5_DIGEST_LENGTH;
            RSA_Digest_Cast  = (void *)CC_MD5;
            break;
        }
    }

    uint8_t *dataToSign = malloc(dataToSignLength);
    memset(dataToSign, 0x0, dataToSignLength);
    
    
    if (!RSA_Digest_Cast([data bytes], (CC_LONG)data.length, dataToSign)) {
        return nil;
    }
    
    NSMutableData *resultData = [[NSMutableData alloc] initWithLength:SecKeyGetBlockSize(self.privateKey)];
    size_t resultDataLength = resultData.length;
    
    OSStatus status = SecKeyRawSign(self.privateKey,
                                    padding,
                                    dataToSign,
                                    dataToSignLength,
                                    [resultData mutableBytes],
                                    &resultDataLength);
    
    if (status == errSecSuccess) {
        return [resultData copy];
    }
    
    return nil;

}

@end
