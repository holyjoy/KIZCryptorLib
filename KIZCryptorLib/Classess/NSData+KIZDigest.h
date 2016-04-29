//
//  NSData+KIZDigest.h
//  KIZCryptorLib
//
//  Created by kingizz on 16/4/15.
//  Copyright © 2016年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (KIZDigest)

- (NSData *)kiz_md2Data;
- (NSString *)kiz_md2String;

- (NSData *)kiz_md4Data;
- (NSString *)kiz_md4String;

- (NSData *)kiz_md5Data;
- (NSString *)kiz_md5String;

- (NSData *)kiz_sha1Data;
- (NSString *)kiz_sha1String;

- (NSData *)kiz_sha224Data;
- (NSString *)kiz_sha224String;

- (NSData *)kiz_sha256Data;
- (NSString *)kiz_sha256String;

- (NSData *)kiz_sha384Data;
- (NSString *)kiz_sha384String;

- (NSData *)kiz_sha512Data;
- (NSString *)kiz_sha512String;

@end
