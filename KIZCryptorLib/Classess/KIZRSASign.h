//
//  KIZRSASHASign.h
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIZRSA.h"

@interface KIZRSASign : NSObject

@property (nonatomic, assign, readonly) SecKeyRef privateKey;

- (instancetype)initWithPrivateKey:(SecKeyRef)privateKey;

- (NSString *)signString:(NSString *)string withDigest:(KIZRSASignDigest)digest;
- (NSData *)signData:(NSData *)data WithDigest:(KIZRSASignDigest)digest;

@end
