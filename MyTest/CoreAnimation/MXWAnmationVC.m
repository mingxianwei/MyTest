//
//  MXWAnmationVC.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/8.
//

#import "MXWAnmationVC.h"

@interface MXWAnmationVC ()


@property (weak, nonatomic) IBOutlet UIView *basciView;

@property (weak, nonatomic) IBOutlet UIImageView *keyFrameAnmoationView;


@property (weak, nonatomic) IBOutlet UIView *gourpAnmationView;

@end

@implementation MXWAnmationVC

#pragma mark - === Selector/IBAction ===

- (IBAction)gouroAnmationTap:(id)sender {

    CAAnimationGroup * gourp = [CAAnimationGroup new];
    
    CAKeyframeAnimation * fanmation = [CAKeyframeAnimation new];
    fanmation.keyPath = @"position";
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:150 startAngle:0 endAngle:2*M_PI clockwise:YES];
    fanmation.path = path.CGPath;
    
    CABasicAnimation * bascAnmation = [CABasicAnimation new];
    bascAnmation.keyPath = @"transform.rotation";
    bascAnmation.byValue = @(15*M_PI);
    
    
    gourp.animations = @[fanmation,bascAnmation];
    
//    gourp.fillMode = kCAFillModeForwards;
//    gourp.removedOnCompletion = NO;
    gourp.duration = 5;
    gourp.repeatCount = 10;
    
    [self.gourpAnmationView.layer addAnimation:gourp forKey:nil];
}



- (IBAction)tapBasciView:(id)sender {
    /** 基本动画 */
    /**
     * 1、创建基本动画对象
     * 2、怎么做动画
     * 3、添加动画（给谁的什么属性做什么动画）
     */
    CABasicAnimation * basciAnimation = [CABasicAnimation new];
    basciAnimation.keyPath = @"position.y";
    
   /** 从哪里->哪里 执行完成会恢复到初始位置 */
//    basciAnimation.fromValue = @(self.basciView.frame.origin.y);
//    basciAnimation.toValue = @(self.basciView.frame.origin.x+1000);
   
    /** 在自身基础上累加 */
    basciAnimation.byValue = @(50);
   
    /** 动画完成之后 设置removedOnCompletion之后不会退到初始状态 */
//    basciAnimation.fillMode = kCAFillModeBoth;z
//    basciAnimation.removedOnCompletion = NO;
    
    [self.basciView.layer addAnimation:basciAnimation forKey:nil];
    
}


- (IBAction)tapKeyFrameAnmation:(id)sender {
    /** 关键帧动画 */
    /**
     * 1、创建基本动画对象
     * 2、怎么做动画
     * 3、添加动画（给谁的什么属性做什么动画）
     */
    
    CAKeyframeAnimation * frameAnmation = [CAKeyframeAnimation new];
    frameAnmation.keyPath = @"position";
    
    /*   给几个值 关键帧的 值
    NSValue * value1 = [NSValue valueWithCGPoint:CGPointMake(0,self.keyFrameAnmoationView.frame.origin.y)];
    NSValue * value2 = [NSValue valueWithCGPoint:CGPointMake(ScreenWidth-self.keyFrameAnmoationView.frame.size.width, self.keyFrameAnmoationView.frame.origin.y)];
    NSValue * value3 = [NSValue valueWithCGPoint:CGPointMake(0, self.keyFrameAnmoationView.frame.origin.y+100)];
    NSValue * value4 = [NSValue valueWithCGPoint:CGPointMake(ScreenWidth-self.keyFrameAnmoationView.frame.size.width, self.keyFrameAnmoationView.frame.origin.y+100)];
    
    frameAnmation.values = @[value1,value2,value4,value3];
    NSLog(@"VALUEW===%@ ====screen= %@ ",frameAnmation.values,[UIScreen mainScreen]);
    
    */
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0,self.keyFrameAnmoationView.frame.origin.y)];
    [path addCurveToPoint:CGPointMake(ScreenWidth-self.keyFrameAnmoationView.frame.size.width, self.keyFrameAnmoationView.frame.origin.y+100) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(300, 300)];
    
    frameAnmation.path = path.CGPath;
    frameAnmation.duration = 0.5;
    frameAnmation.repeatCount = 3; // INT_MAX;
    
//    frameAnmation.fillMode = kCAFillModeForwards;
//    frameAnmation.removedOnCompletion  = NO;
    
    [self.keyFrameAnmoationView.layer addAnimation:frameAnmation forKey:nil];
}



#pragma mark - === LifeClicle ===

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)dealloc {
    NSLog(@"我被释放了%@",[self description]);
}

@end
