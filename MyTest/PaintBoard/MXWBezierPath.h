//
//  MXWBezierPath.h
//  MyTest
//
//  Created by 明先伟 on 2022/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXWBezierPath : UIBezierPath
@property (nonatomic,strong) UIColor * color;


/**
 * 将贝塞尔曲线转化成字典 字典键值如下:
 * {
 * @:"color": HexString
 * @:"points": 装有Points的数组
 * @:"width":线宽 NSValue
 * }
 *
 */
-(NSDictionary *)dicFromBezierPath;

+(MXWBezierPath *)bezierPathFromDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
