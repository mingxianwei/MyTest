//
//  UIColor+Hex.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

/** 将Hexstring 转换成UIColor对象 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(CGFloat)alpha;

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithRGBAlphaHex:(UInt32)hex;
+ (UIColor *)colorWithRGBHex:(UInt32)hex withAlpha:(CGFloat)alpha;

/** 将UIColor对象转换成 hex string */
- (NSString *)hexadecimalFromUIColor;

@end

NS_ASSUME_NONNULL_END
