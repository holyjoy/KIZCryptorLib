
a crypt kit, support crypt algorithm：RSA、RSA sign/verify(SHA1、SHA256、SHA512)、SHA1、MD5

###How to use:

first, you should init `public key` and `private key`:

```
NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];

SecKeyRef publickKey = [KIZCryptUtil getPublicSecKeyRefFromDerFile:publicKeyPath];
SecKeyRef privateKey = [KIZCryptUtil getPrivateSecKeyRefFromCerFile:privateKeyPath password:@"123456"];
```

then,

RSA crypt:

```
NSString *string = @"hello kingizz!";

NSString *encryptString = [rsa encryptString:string];
NSString *decryptSring  = [rsa decryptString:encryptString];
```

RSA sign / verify:

```
KIZRSASHASign   *rsaSign    = [[KIZRSASHASign alloc] initWithPrivateKey:privateKey];
KIZRSASHAVerify *rsaVerify  = [[KIZRSASHAVerify alloc] initWithPublicKey:publickKey];

NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding];
NSData *signedData = [rsaSign signData:plainData WithDigest:KIZRSASignSHA1]; 
BOOL valid = [rsaVerify verifyPlainData:plainData signatureData:signedData withDigest:KIZRSASignSHA1];
```

MD5 digest:

```
//file md5
NSString *path = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"txt"];
NSString *md5String = [NSString kiz_md5StringWithContentOfFile:path];
NSLog(@"file md5 : %@", md5String);

//string's md5
NSString *md5 = [string kiz_md5String];
NSLog(@"string %@'s md5-->%@", string, md5);
```

SHA1:

```
//file SHA1
NSString *sha1String = [NSString kiz_sha1StringWithContentOfFile:path];
NSLog(@"file's SHA1 : %@", sha1String);

//String's SHA1
NSLog(@"string %@'s sha1：%@", string, [string kiz_sha1String]);

```


###appendixes, how to generate public key and private key file

- 生成模长为1024bit的私钥

```
openssl genrsa -out private_key.pem 1024
```
- 生成certification require file

```
openssl req -new -key private_key.pem -out rsaCertReq.csr
```
- 生成certification 并指定过期时间

```
openssl x509 -req -days 3650 -in rsaCertReq.csr -signkey private_key.pem -out rsaCert.crt
```
- 生成公钥供iOS使用

```
openssl x509 -outform der -in rsaCert.crt -out public_key.der
```
- 生成私钥供iOS使用 这边会让你输入密码，后期用到在生成secKeyRef的时候会用到这个密码

```
openssl pkcs12 -export -out private_key.p12 -inkey private_key.pem -in rsaCert.crt
```
- 生成pem结尾的公钥供Java使用

```
openssl rsa -in private_key.pem -out rsa_public_key.pem -pubout
```
- 生成pem结尾的私钥供Java使用

```
openssl pkcs8 -topk8 -in private_key.pem -out pkcs8_private_key.pem -nocrypt
```
