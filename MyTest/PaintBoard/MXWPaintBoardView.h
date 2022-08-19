//
//  MXWPaintBoardView.h
//  MyTest
//
//  Created by 明先伟 on 2022/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXWPaintBoardView : UIView

@property (nonatomic,assign) CGFloat lineWith;
@property (nonatomic,strong) UIColor * lineColor;

- (void)reback;

- (void)clear;

- (void)eraser;

- (void)saveToImage;

@end

NS_ASSUME_NONNULL_END
