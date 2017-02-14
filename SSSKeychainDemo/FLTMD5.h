//
//  FLTMD5.h
//  SSSKeychainDemo
//
//  Created by ComAnvei on 16/5/24.
//  Copyright © 2016年 FLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTMD5 : NSObject
/**
 *  计算一个文件的md5值
 *
 *  @param path 文件路径
 *
 *  @return md5值
 */
+(NSString*)getFileMD5WithPath:(NSString*)path;
//得到字符串的MD5值
+ (NSString *)getStringMd5:(NSString *)str;
//计算NSData 的MD5值
+(NSString*)getMD5WithData:(NSData*)data;
@end
