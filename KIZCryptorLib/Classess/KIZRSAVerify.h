//
//  KIZRSASHAVerify.h
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIZRSA.h"

@interface KIZRSAVerify : NSObject

@property (nonatomic, assign, readonly) SecKeyRef publicKey;

- (instancetype)initWithPublicKey:(SecKeyRef)publicKey;

- (BOOL)verifyPlainData:(NSData *)plainData signatureData:(NSData *)signatureData withDigest:(KIZRSASignDigest)digest;

@end
