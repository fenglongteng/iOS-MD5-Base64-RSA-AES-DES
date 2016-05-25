//
//  FLTMD5.m
//  SSSKeychainDemo
//
//  Created by ComAnvei on 16/5/24.
//  Copyright © 2016年 FLT. All rights reserved.
//

#import "FLTMD5.h"
//需要加入依赖库  libSystem.tdb
#import <CommonCrypto/CommonDigest.h>
@implementation FLTMD5
+(NSString *)md5HexDigest:(NSString *)input{
    
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result];
    }
    return ret;
}
@end
