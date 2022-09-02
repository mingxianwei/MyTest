//
//  MXWPieModel.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXWPieModel : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *tittle;

/** 数值 CGFloat */
@property (nonatomic, assign) CGFloat value;

/** 颜色 */
@property (nonatomic, strong) UIColor *color;

/** 便捷构造方法 */
+ (instancetype)mxwPieModelWithTittle:(NSString *)tittle andValue:(CGFloat)value andColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
