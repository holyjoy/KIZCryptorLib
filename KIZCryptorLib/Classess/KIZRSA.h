//
//  KIZRSA.h
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KIZRSASignDigest) {
    
    KIZRSASignSHA1,      //the default
    KIZRSASignSHA224,
    KIZRSASignSHA256,
    KIZRSASignSHA384,
    KIZRSASignSHA512,
    KIZRSASignMD2,
    KIZRSASignMD5,
};
