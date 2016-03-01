//
//  KIZRSACryptor.h
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KIZRSACryptorPadding) {
    KIZRSACryptorPaddingNone,
    KIZRSACryptorPaddingPKCS1   //the default
};

@interface KIZRSACryptor : NSObject

@property (nonatomic, assign) KIZRSACryptorPadding padding;

- (instancetype)initWithPublicKey:(SecKeyRef)publicKey privateKey:(SecKeyRef)privateKey;

/**
 *  使用公钥加密
 *
 *  @param string
 *
 *  @return
 */
- (NSString *)encryptString:(NSString *)string;
/**
 *  使用私钥解密
 *
 *  @param string
 *
 *  @return 
 */
- (NSString *)decryptString:(NSString *)string;

@end
