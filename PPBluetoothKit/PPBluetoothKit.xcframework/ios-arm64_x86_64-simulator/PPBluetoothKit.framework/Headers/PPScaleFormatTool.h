//
//  PPScaleFormatTool.h
//  PPBlueToothDemo
//
//  Created by 彭思远 on 2020/8/3.
//  Copyright © 2020 彭思远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PPScaleFormatTool : NSObject
+ (NSString *)addZero:(NSString *)str withLength:(int)length;

+ (NSString *)addZeroBehind:(NSString *)str withLength:(int)length;

+ (NSInteger)numberHexString:(NSString *)aHexString;

+ (NSString *)data2String:(NSData *)data;

+ (Byte)convertDecimalTo0x:(NSInteger) decimal;

+ (NSString *)getHexByDecimal:(NSInteger)decimal;

+ (NSData *)convertHexStrToData:(NSString *)str;

+ (NSString *)getBinaryStrByHexStr:(NSString *)hex;

//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;

+ (UIImage *)text2Image:(NSString *)text;

+ (UIImage*)covertToGrayImageFromImage:(UIImage*)sourceImage;

+ (NSData *)image2Bitmap:(UIImage *)image;

+ (NSString *)reversStrWith2Step:(NSString *)str;

+ (NSString *)addF:(NSString *)str withLength:(int)length;

+ (NSString *)add0x30:(NSString *)str withLength:(int)length;

+ (NSString *)getHexByBinary:(NSString *)binary;

+ (NSData *)trimData:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
