//
//  KIZRSACryptor.m
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import "KIZRSACryptor.h"

@interface KIZRSACryptor ()

@property (nonatomic, assign) SecKeyRef publicKey;
@property (nonatomic, assign) SecKeyRef privateKey;

@end

@implementation KIZRSACryptor

- (instancetype)initWithPublicKey:(SecKeyRef)publicKey privateKey:(SecKeyRef)privateKey{
    self = [super init];
    if (self) {
        _publicKey  = publicKey;
        _privateKey = privateKey;
        _padding    = KIZRSACryptorPaddingPKCS1;
    }
    return self;
}

- (NSString *)encryptString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return base64_encode_data([self encryptData:data]);
}

- (NSData *)encryptData:(NSData *)data{
    SecPadding padding;
    switch (self.padding) {
        case KIZRSACryptorPaddingNone: {
            padding = kSecPaddingNone;
            break;
        }
        case KIZRSACryptorPaddingPKCS1: {
            padding = kSecPaddingPKCS1;
            break;
        }
    }
    NSMutableData *resultData = [[NSMutableData alloc] initWithLength:SecKeyGetBlockSize(self.publicKey)];
    size_t resultDataLength = [resultData length];
    OSStatus status = SecKeyEncrypt(self.publicKey,
                                    padding,
                                    [data bytes],
                                    data.length,
                                    [resultData mutableBytes],
                                    &resultDataLength
                                    );
    
    if (status == errSecSuccess) {
        resultData.length = resultDataLength;
        return [resultData copy];
    }

    return nil;
}

- (NSString *)decryptString:(NSString *)string{
    NSData *data = base64_decode(string);
    NSData *decryptData = [self decryptData:data];
    return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
}

- (NSData *)decryptData:(NSData *)data{
    SecPadding padding;
    switch (self.padding) {
        case KIZRSACryptorPaddingNone: {
            padding = kSecPaddingNone;
            break;
        }
        case KIZRSACryptorPaddingPKCS1: {
            padding = kSecPaddingPKCS1;
            break;
        }
    }
    NSMutableData *resultData = [[NSMutableData alloc] initWithLength:SecKeyGetBlockSize(self.privateKey)];
    size_t resultDataLength = [resultData length];
    OSStatus status = SecKeyDecrypt(self.privateKey,
                                    padding,
                                    [data bytes],
                                    data.length,
                                    [resultData mutableBytes],
                                    &resultDataLength);
    if (status == errSecSuccess) {
        resultData.length = resultDataLength;
        return [resultData copy];
    }
    return nil;
}


static NSString *base64_encode_data(NSData *data){
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

static NSData *base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

@end
