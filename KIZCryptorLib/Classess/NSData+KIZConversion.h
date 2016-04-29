//
//  NSData+KIZConversion.h
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (KIZConversion)

/* Returns hexadecimal string of NSData. Empty string if data is empty.   */
- (NSString *)kiz_toHexadecimalString;

@end
