//
//  MXWPotoBrowserTransAnimat.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 代理方法 来计算要执行的 动画*/
@protocol MXWPhotoBrowserPresentedDelegate <NSObject>

@required
/** 展示转场动画的图片视图 */
- (UIImageView *)imageViewFromPresentAtIndexPath:(NSIndexPath *)indexPath;

/** 专场动画图片的  初始位置 */
-(CGRect)fromRectAtPresentingVCAtIndexPath:(NSIndexPath *)indexPath;

/** 专场动画的图片 最终位置 */
-(CGRect)toRectAtPresentedVCAtIndexpath:(NSIndexPath *)indexPath;

@end


/** 代理方法 来计算要执行的 动画*/
@protocol MXWPhotoBrowserDismissdDelegate <NSObject>

@required
/** 展示转场动画的图片视图 */
-(UIImageView *)imageViewForDissmiss;

-(NSIndexPath *)indexPathForDismiss;

@end







/** 管理图片查看器 的转场动画 */
@interface MXWPotoBrowserTransAnimat :NSObject <UIViewControllerTransitioningDelegate>

/** 展现动画代理 */
@property (nonatomic, weak) id <MXWPhotoBrowserPresentedDelegate> presentDelegate;

/** 消失动画代理 */
@property (nonatomic, weak) id <MXWPhotoBrowserDismissdDelegate> dismissDelegate;


@property (nonatomic, strong) NSIndexPath *indexPath;

@end





NS_ASSUME_NONNULL_END
