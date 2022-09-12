//
//  MXWPotoBrowserTransAnimat.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/12.
//

#import "MXWPotoBrowserTransAnimat.h"

@interface MXWPotoBrowserTransAnimat () <UIViewControllerAnimatedTransitioning>

/** 用来标记是否要展示Dissmiss */
@property (nonatomic, assign) BOOL isDissmiss;

@end


@implementation MXWPotoBrowserTransAnimat


/** 由谁提供转场动画  return self 表示由 我自己实现转场动画*/
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.isDissmiss = NO;
    return  self;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.isDissmiss = YES;
    return self;
}


#pragma mark - === UIViewControllerAnimatedTransitioning ===

/** 返回动画时长 */
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}


/** 具体的 动画实现    */  /** 一旦实现这个方法，系统将不再提供转场动画 ，由自己实现 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
//    UIViewController * fromeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//
//    UIView * fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    UIView * toView =  [transitionContext viewForKey:UITransitionContextToViewKey];
//
//
    /** 判断是 展示动画还是 Dismiss 动画 */
    if (self.isDissmiss) {
        [self dismissAnimation:transitionContext];
    } else {
        [self presentAnimation:transitionContext];
    }
    
}


/** 在这里执行 展示动画 */
- (void)presentAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIImageView * imageView  = [self.presentDelegate imageViewFromPresentAtIndexPath:self.indexPath];
    CGRect fromRect = [self.presentDelegate fromRectAtPresentingVCAtIndexPath:self.indexPath];
    CGRect toRect = [self.presentDelegate toRectAtPresentedVCAtIndexpath:self.indexPath];
    
    
    
    UIView * toView =  [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.hidden = YES;
    [transitionContext.containerView addSubview:toView];
    
    UIView * View = [[UIView alloc] initWithFrame:toView.frame];
    View.backgroundColor = [UIColor blackColor];
    View.alpha = 0;
    [transitionContext.containerView addSubview:View];
    
    imageView.frame = fromRect;
    [transitionContext.containerView addSubview:imageView];
  
    
    [UIView animateWithDuration:0.25  animations:^{
        imageView.frame = toRect;
        View.alpha = 1;
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        [View removeFromSuperview];
        [imageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

/** 在这里执行 Dismiss动画 */
- (void)dismissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIImageView * imageView = [self.dismissDelegate imageViewForDissmiss];
    
    NSIndexPath * indexpath = [self.dismissDelegate indexPathForDismiss];
    CGRect formRect = [self.presentDelegate fromRectAtPresentingVCAtIndexPath:indexpath];
    [transitionContext.containerView addSubview:imageView];
    
    UIView * formView =  [transitionContext viewForKey:UITransitionContextFromViewKey];
    formView.hidden = YES;
    
    [UIView animateWithDuration:0.25  animations:^{
        imageView.frame = formRect;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}




@end
