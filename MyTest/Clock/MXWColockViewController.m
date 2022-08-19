//
//  MXWColockViewController.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/4.
//

#import "MXWColockViewController.h"

@interface MXWColockViewController ()

@property (nonatomic,weak) CALayer * secondLayer;

@property (nonatomic,weak) CALayer * minuteLayer;

@property (nonatomic,weak) CALayer * hourLayer;



@end

@implementation MXWColockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"时钟";
    [self.navigationItem.leftBarButtonItem setTitle:@"返回"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1 添加表盘
    CALayer * colockLayer = [[CALayer alloc] init];
    colockLayer.bounds = CGRectMake(0, 0, 200, 200);
//    colockLayer.position = CGPointMake(200, 200);
    colockLayer.position = self.view.center;
    
    colockLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Clock"].CGImage);
    colockLayer.cornerRadius = 100;
    colockLayer.borderWidth =10;
    colockLayer.borderColor = [UIColor blackColor].CGColor;
    colockLayer.masksToBounds = YES;
    
    //创建秒针
    CALayer * secondLayer = [[CALayer alloc] init];
    secondLayer.bounds= CGRectMake(0, 0, 2, 100);
//    secondLayer.position = CGPointMake(200, 200);
    secondLayer.position = self.view.center;
    secondLayer.backgroundColor  = [UIColor redColor].CGColor;
    secondLayer.anchorPoint = CGPointMake(0.5, 0.8);
    
    //创建分针
    CALayer * minuteLayer = [[CALayer alloc] init];
    minuteLayer.bounds= CGRectMake(0, 0, 3, 80);
    minuteLayer.position = self.view.center;//CGPointMake(200, 200);
    minuteLayer.backgroundColor  = [UIColor blackColor].CGColor;
    minuteLayer.anchorPoint = CGPointMake(0.5, 0.8);
    
    //创建时针
    CALayer * hourLayer = [[CALayer alloc] init];
    hourLayer.bounds= CGRectMake(0, 0, 5, 60);
    hourLayer.position = self.view.center;//CGPointMake(200, 200);
    hourLayer.backgroundColor  = [UIColor blackColor].CGColor;
    hourLayer.anchorPoint = CGPointMake(0.5, 0.8);

    
    //添加的先后顺序会影响展示
    [self.view.layer addSublayer:colockLayer];
    [self.view.layer addSublayer:hourLayer];
    [self.view.layer addSublayer:minuteLayer];
    [self.view.layer addSublayer:secondLayer];
    
    self.hourLayer = hourLayer;
    self.secondLayer = secondLayer;
    self.minuteLayer = minuteLayer;
    
    // 将屏幕刷新
    CADisplayLink * disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(flushLayer)];
    [disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}



- (void)flushLayer{
    
    NSDate * date = [NSDate date];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger hour = [calendar component:NSCalendarUnitHour fromDate:date];
    NSInteger minute = [calendar component:NSCalendarUnitMinute fromDate:date];
    NSInteger second = [calendar component:NSCalendarUnitSecond fromDate:date];
    
    // 获取的时间为 24小时  如果小时打鱼12  应当减去12
    if (hour >= 12) {
        hour = hour - 12;
    }
    
    self.secondLayer.affineTransform = CGAffineTransformMakeRotation(second/60.0*2*M_PI);
    self.hourLayer.affineTransform = CGAffineTransformMakeRotation(hour/12.0 *2*M_PI);
    self.minuteLayer.affineTransform = CGAffineTransformMakeRotation(minute/60.0*2*M_PI);

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
