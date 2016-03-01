//
//  ViewController.m
//  KIZCryptoLib
//
//  Created by Eugene on 15/11/10.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import "ViewController.h"
#import "KIZCryptoKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //RSA 加密解密
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    
    SecKeyRef publickKey = [KIZCryptUtil getPublicSecKeyRefFromDerFile:publicKeyPath];
    SecKeyRef privateKey = [KIZCryptUtil getPrivateSecKeyRefFromCerFile:privateKeyPath password:@"123456"];
    
    KIZRSACryptor *rsa = [[KIZRSACryptor alloc] initWithPublicKey:publickKey
                                                       privateKey:privateKey
                          ];
    
    NSString *string = @"hello kingizz!";
    
    NSString *encryptString = [rsa encryptString:string];
    NSString *decryptSring  = [rsa decryptString:encryptString];
    
    NSLog(@"\n原文：%@\n密文：%@\n解密：%@", string, encryptString, decryptSring);
    
    
    //RSA 私钥签名， 公钥验证签名
    KIZRSASHASign   *rsaSign    = [[KIZRSASHASign alloc] initWithPrivateKey:privateKey];
    KIZRSASHAVerify *rsaVerify  = [[KIZRSASHAVerify alloc] initWithPublicKey:publickKey];
    
    NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *signedData = [rsaSign signData:plainData WithDigest:KIZRSASHASignSHA1];
    BOOL valid = [rsaVerify verifyPlainData:plainData signatureData:signedData withDigest:KIZRSASHASignSHA1];
    NSLog(@"RSA签名验证：%@", valid ? @"valid" : @"invalid");
    
    
    //散列算法
    NSString *path = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"txt"];
    NSString *md5String = [KIZDigestCryptor md5DigestOfFileAtPath:path];
    NSLog(@"文件的md5 : %@", md5String);
    
    
    NSString *md5 = [KIZDigestCryptor md5DigestOfString:string];
    NSLog(@"字符串%@的md5-->%@", string, md5);
    
    
    NSString *sha1String = [KIZDigestCryptor sha1DigestOfFileAtPath:path];
    NSLog(@"文件的SHA1 : %@", sha1String);
    
    NSLog(@"字符串%@的sha1：%@", string, [KIZDigestCryptor sha1DigestOfString:string]);
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
