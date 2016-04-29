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
    KIZRSASign   *rsaSign    = [[KIZRSASign alloc] initWithPrivateKey:privateKey];
    KIZRSAVerify *rsaVerify  = [[KIZRSAVerify alloc] initWithPublicKey:publickKey];
    
    NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *signedData = [rsaSign signData:plainData WithDigest:KIZRSASignSHA1];
    BOOL valid = [rsaVerify verifyPlainData:plainData signatureData:signedData withDigest:KIZRSASignSHA1];
    NSLog(@"RSA签名验证：%@", valid ? @"valid" : @"invalid");
    
    
    //散列算法
    NSString *path = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"txt"];
    NSString *md5String = [NSString kiz_md5StringWithContentOfFile:path];
    NSLog(@"文件的md5 : %@", md5String);
    
    
    NSString *md5 = [string kiz_md5String];
    NSLog(@"字符串%@的md5-->%@", string, md5);
    
    
    NSString *sha1String = [NSString kiz_sha1StringWithContentOfFile:path];
    NSLog(@"文件的SHA1 : %@", sha1String);
    
    NSLog(@"字符串%@的sha1：%@", string, [string kiz_sha1String]);
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
