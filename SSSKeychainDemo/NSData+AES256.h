//
//  NSData+AES256.h
//  SSSKeychainDemo
//
//  Created by ComAnvei on 17/2/14.
//  Copyright © 2017年 FLT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES256)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end
