//
//  MXWPaintBoardView.h
//  MyTest
//
//  Created by 明先伟 on 2022/8/4.
//

#import <UIKit/UIKit.h>
#import "MXWBezierPath.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXWPaintBoardView : UIView

@property (nonatomic,assign) CGFloat lineWith;
@property (nonatomic,strong) UIColor * lineColor;


- (void)reback;

- (void)clear;

- (void)eraser;

- (void)saveToImage;

- (void)setPathwithArry:(NSArray<MXWBezierPath *> * _Nonnull)pathArry;
/** 给当前画板的每一条路径转换成字典之后 加入到数组中 */
- (NSArray *)arrayWithMXWBezierPathArray;

@end

NS_ASSUME_NONNULL_END
