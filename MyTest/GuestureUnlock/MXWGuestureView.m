//
//  MXWGuestureView.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/18.
//

#import "MXWGuestureView.h"


//这里定义的是按钮的个数。可以修改 但是一般为平方数 这样横竖数量都是相等。  可以为9 /16 /25
#define KButtonNumber 9

// 定义按钮之间的间距
#define KMargein  30


typedef NS_ENUM(NSInteger,kPassWordCheckType) {
    kPassWordCheckDefault = 0,  //默认状态，没有验证
    kPassWordCheckRight = 1,    // 密码正确
    kPassWordCheckWrong = 2     // 密码错误
};



@interface MXWGuestureView ()

@property (nonatomic, strong) NSMutableArray *butArry;
@property (nonatomic, assign) CGPoint currPoint;
// 标记当前的 状态 默认是0  密码正确 为 1  密码错误为 2
@property (nonatomic, assign) kPassWordCheckType flage;

@end


@implementation MXWGuestureView



#pragma mark - === 重绘 ===
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [self.butArry enumerateObjectsUsingBlock:^(UIButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [path moveToPoint:obj.center];
        } else {
            [path addLineToPoint:obj.center];
        }
    }];
    
    // 只有正常情况才连线到手指，当计算结果时候就不连接最后一条线
    if (self.flage == 0 && self.butArry.count > 0) {
        [path addLineToPoint:self.currPoint];
    }
    
    
    // 密码错误就 花红线，其他状态就是正常线
    if (self.flage == 2) {
        [[UIColor redColor] set];
    } else {
        [[UIColor colorWithRed:0 green:177/255.0 blue:1.0 alpha:1] set];
    }
    
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    
    [path setLineWidth:15];
    
    [path stroke];
  
}

#pragma mark - === 懒加载 ===
-(NSMutableArray *)butArry {
    if (_butArry == nil) {
        _butArry = [NSMutableArray arrayWithCapacity:KButtonNumber];
    }
    return _butArry;
}

#pragma mark - === 初始化 ===
/**
 当View 初始化时候应该给他创建按钮
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    /**
     创建按钮  但是初始化时候 这个View 还没有Frame 所以无法 设置子控件frame，所以需要在 layoutsubView 的方式来设置frame
     */
    for (int i = 0; i<KButtonNumber; i++) {
        UIButton * button = [[UIButton alloc] init];
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        //需要把按钮的 交互禁用 使用testHit 来控制选中状态
        button.userInteractionEnabled = NO;
        
        // 设置button 的错误样式
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
        
        [self addSubview:button];
    }
    
}


#pragma mark - === 子控件设置Frame===
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //给子控件设置frame
    NSInteger rowNumber = sqrt(KButtonNumber);
    CGFloat width = (self.bounds.size.width - KMargein * (rowNumber+1))/rowNumber*1.0;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = (idx % rowNumber + 1)*KMargein + idx % rowNumber*width;
        CGFloat y = (idx/rowNumber +1)*KMargein + idx/rowNumber * width;
        obj.frame = CGRectMake(x, y, width, width);
    }];
}


#pragma mark - === 触摸视图的几个方法TouchBegan/Movied/ende ===

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    //记录当前触摸点
    self.currPoint = point;
    self.flage = 0;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * button = (UIButton *)obj;
        button.selected = NO;
        button.enabled = YES;
    }];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    
    //记录当前触摸点
    self.currPoint = point;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, point)) {
            UIButton * button = (UIButton *)obj;
            //如果已经连线了就不用再加入数组中
            if (button.isSelected == NO) {
                button.selected = YES;
                button.enabled = YES;
                [self.butArry addObject:button];
            }
            //如果找到 就直接停止循环。
            *stop = YES;
        }
    }];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString * password = [self caculatePassword];
    if(self.ChackPasswordBlock){
        BOOL result = self.ChackPasswordBlock(password);
           if (result == YES) {
               [self correctStatus];
           } else {
               [self errorStatus];
           }
    }
    
}

#pragma mark - === 成功/失败 之时 展示状态后清空状态 ===

/** 清空状态 */
- (void)clearStatus {
    __weak typeof(self) weakSelf = self;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * button = (UIButton *)obj;
        button.selected = NO;
        button.enabled = YES;
        [weakSelf.butArry removeAllObjects];
        [weakSelf setNeedsDisplay];
    }];
    
    //清空状态之后的回调
    if (self.afterClearBlock) {
        self.afterClearBlock();
    }
}

/** 成功之后重置状态 和回调 */
- (void)correctStatus {
    self.userInteractionEnabled = NO;
    self.flage = 1;
    [self setNeedsDisplay];
    
    //__weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self clearStatus];
        self.userInteractionEnabled = YES;
    });
}


/** 失败时候 重置状态 */
- (void)errorStatus {
    self.userInteractionEnabled = NO;
    self.flage = 2;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * button = (UIButton *)obj;
        if (button.selected == YES) {
            button.selected = NO;
            button.enabled = NO;
        }
    }];
    [self setNeedsDisplay];
    
   // __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self clearStatus];
        self.userInteractionEnabled = YES;
    });
}


#pragma mark - === 根据选择顺序 拼接密码 ===

-(NSString *)caculatePassword {
    NSMutableString * string = [NSMutableString string];
    for (UIButton * button in self.butArry) {
       [string appendFormat:@"%zd",button.tag];
    }
    return string.copy;
}


-(void)dealloc {
    NSLog(@"我被释放了%@",[self class]);
}
@end
