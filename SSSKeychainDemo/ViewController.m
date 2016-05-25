//
//  ViewController.m
//  SSSKeychainDemo
//
//  Created by ComAnvei on 16/5/24.
//  Copyright © 2016年 FLT. All rights reserved.
//

#import "ViewController.h"
#import <SSKeychain.h>
#import "FLTMD5.h"
#import "AESCrypt.h"
#import "FLTBase64.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //SSkeychain第三方加密 采用DES（）对本地化用户名 密码进行加密 对称加密
    NSString *bundleID = [NSBundle mainBundle].bundleIdentifier;
    [SSKeychain setPassword:@"111" forService:bundleID account:@"ni"];
    [SSKeychain setPassword:@"222" forService:bundleID account:@"wo"];
    [SSKeychain setPassword:@"333" forService:bundleID account:@"ta"];
    
    NSString *passwords = [SSKeychain passwordForService:bundleID account:@"wo"];
    NSLog(passwords);
    
    
    //MD5加密 MD5是不可逆的只有加密没有解密
    NSString *userName = @"cerastes";
    NSString *password = @"hello Word";
    //   MD5加密 单纯的MD5加密不安全 需要加盐，加盐就是在要加密的内容后加一些常量，常量越长越安全
    //盐值
    NSString *salt = @"追加的：盐值";
    password = [password stringByAppendingString:salt];
    NSString *md5 = [FLTMD5 md5HexDigest:password];
    NSLog(@"%@",md5);
    NSLog(@"%lu",(unsigned long)md5.length);
    
    // AES加密  （高级加密标准） 对称加密
    NSString *encryptedData = [AESCrypt encrypt:userName password:password];//加密
    NSString *message = [AESCrypt decrypt:encryptedData password:password]; //解密
    NSLog(@"加密结果 = %@",encryptedData);
    NSLog(@"解密结果 = %@",message);
    
    //base64加密 利用第三方GTMBase64加密
    NSString *baseEncodeString = [FLTBase64 encodeBase64String:password];
    NSString *baseDecodeString = [FLTBase64 decodeBase64String:baseEncodeString];
    NSLog(@"baseEncodeString = %@",baseEncodeString);
    NSLog(@"baseDecodeString = %@",baseDecodeString);
    
    //base64 用系统加密
     NSString *originStr = @"originStr";
    NSData* originData = [originStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"encodeResult=%@",encodeResult);
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:encodeResult options:0];
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    NSLog(@"decodeStr=%@",decodeStr);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
