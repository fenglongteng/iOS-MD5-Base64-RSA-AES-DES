//
//  NSString+AES256.h
//  SSSKeychainDemo
//
//  Created by ComAnvei on 17/2/14.
//  Copyright © 2017年 FLT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+AES256.h"
@interface NSString (AES256)
-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;
@end
