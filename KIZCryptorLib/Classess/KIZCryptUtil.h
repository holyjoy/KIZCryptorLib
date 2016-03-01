//
//  KIZCerUtil.h
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIZCryptUtil : NSObject

+ (SecKeyRef)getPublicSecKeyRefFromDerFile:(NSString *)filePath;

+ (SecKeyRef)getPrivateSecKeyRefFromCerFile:(NSString *)filePath password:(NSString *)password;

@end
