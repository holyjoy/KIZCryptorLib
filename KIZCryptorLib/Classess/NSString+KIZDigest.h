//
//  NSString+KIZDigest.h
//  KIZCryptorLib
//
//  Created by kingizz on 16/4/15.
//  Copyright © 2016年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KIZDigest)

+ (instancetype)kiz_md2StringWithContentOfFile:(NSString *)path;
+ (instancetype)kiz_md4StringWithContentOfFile:(NSString *)path;
+ (instancetype)kiz_md5StringWithContentOfFile:(NSString *)path;
+ (instancetype)kiz_sha1StringWithContentOfFile:(NSString *)path;
+ (instancetype)kiz_sha224StringWithContentOfFile:(NSString *)path;
+ (instancetype)kiz_sha256StringWithContentOfFile:(NSString *)path;
+ (instancetype)kiz_sha384StringWithContentOfFile:(NSString *)path;
+ (instancetype)kiz_sha512StringWithContentOfFile:(NSString *)path;

- (NSString *)kiz_md2String;
- (NSString *)kiz_md4String;
- (NSString *)kiz_md5String;

- (NSString *)kiz_sha1String;
- (NSString *)kiz_sha224String;
- (NSString *)kiz_sha256String;
- (NSString *)kiz_sha384String;
- (NSString *)kiz_sha512String;

@end
