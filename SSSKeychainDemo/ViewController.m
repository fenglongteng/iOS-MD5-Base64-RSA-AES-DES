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
#import "NSString+AES256.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark SSkeychain第三方加密（苹果钥匙串封装） 采用AES（）对本地化用户名 密码进行加密 对称加密
    NSString *userName = @"cerastes";
    NSString *password = @"新浪科技讯 北京时间5月25日早间消息，美国超级高铁公司Hyperloop Transportation Technologies(HTT)周二公布了一种智能材料。这种材料集成了传感器，将被用于制造超级高铁的车辆。HTT表示，这种材料主要由轻量级的碳纤维构成，强度超过任何钢材料10倍，而且比铝合金还轻，被称作“Vibranium”(汎合金，注：与漫画人物“美国队长”盾牌的材料同名)。利用这种材料可以降低车辆长途行驶所需的能耗。此外，材料内集成的传感器可以测量车辆的信息，并将其回传给运营中心。这些传感器可以实时读取车辆的温度、稳定度和完整度，确保安全和性能。Hyperloop超级高铁的时速最高可以达到700英里(约合1127公里)，最先由特斯拉CEO伊隆·马斯克(Elon Musk)提出。目前，有两家公司试图将马斯克的设想变为现实，而HTT是其中之一。另一家名为Hyperloop One的公司本月早些时候在内华达州的沙漠中展示了测试轨道的初步工作。HTT尚未公布类似的磁力推进系统。该公司目前专注于安全性方面的创新。该公司计划利用两层智能材料去建造车辆，因此即使外层材料损毁，车辆仍可以安全运行。　HTT CEO德科·阿尔伯恩(Derk Ahlborn)表示：“安全性是我们系统最重要的一个方面。”(维金)";
    NSString *bundleID = [NSBundle mainBundle].bundleIdentifier;
    [SSKeychain setPassword:@"111" forService:bundleID account:@"ni"];
    [SSKeychain setPassword:password forService:bundleID account:@"wo"];
    [SSKeychain setPassword:@"333" forService:bundleID account:@"ta"];
    [SSKeychain deletePasswordForService:bundleID account:@"ni"];
    NSString *passwords = [SSKeychain passwordForService:bundleID account:@"wo"];
    NSLog(@"SSkeychain解密=====%@",passwords);
    //    // AES加密  （高级加密标准） 对称加密
    //    NSString *encryptedData = [AESCrypt encrypt:password password:userName];//加密
    //    NSString *message = [AESCrypt decrypt:encryptedData password:userName]; //解密
    //    NSLog(@"AES加密 ========== %@",encryptedData);
    //    NSLog(@"AES解密结果 ============ %@",message);
#pragma mark 工具类别加密
    NSString *key1  = @"wokao";
    NSString *password1 = @"111111111111111";
    NSString *password1Encode = [password1 aes256_encrypt:key1];
    NSString *password1Decode = [password1Encode aes256_decrypt:key1];
    NSLog(@"%@",password1Decode);
    UIImage *image = [UIImage imageNamed:@"startup1@2x.png"];
    NSData *data = UIImagePNGRepresentation(image);
    NSData *dataEncode = [data aes256_encrypt:key1];
    NSData *dataDecode = [dataEncode aes256_decrypt:key1];
   image = [UIImage imageWithData:dataDecode];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    
#pragma mark MD5加密 MD5是不可逆的只有加密没有解密
   
    //   MD5加密 单纯的MD5加密不安全 需要加盐，加盐就是在要加密的内容后加一些常量，常量越长越安全
    //盐值
    //加盐的话加时间戳 字符串折叠追加 多次md5
    NSString *salt = @"追加的：盐值";
    password = [password stringByAppendingString:salt];
    NSString *md5 = [FLTMD5 getStringMd5:password];
    NSLog(@"MD5摘要算法========%@",md5);
    NSLog(@"MD5加密后长度===========%lu",(unsigned long)md5.length);

#pragma mark base64加密 利用第三方GTMBase64加密
    NSString *baseEncodeString = [FLTBase64 encodeBase64String:password];
    NSString *baseDecodeString = [FLTBase64 decodeBase64String:baseEncodeString];
    NSLog(@"GTMBase64加密 ============== %@",baseEncodeString);
    NSLog(@"GTMBase64解密 =============== %@",baseDecodeString);
    
#pragma mark base64 用系统加密 这里只支持英文。
     NSString *originStr = @"wwwwwww";
    NSData* originData = [originStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"base64加密===============%@",encodeResult);
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:encodeResult options:0];
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    NSLog(@"base64解密===============%@",decodeStr);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
