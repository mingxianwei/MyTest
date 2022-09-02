//
//  MXWColumnarView.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/2.
//

#import "MXWColumnarView.h"

@interface MXWColumnarView ()

/** 最大的值 */
@property (nonatomic, assign) CGFloat maxValue;

@end


@implementation MXWColumnarView

/** 赋值时候 求出最大值 */
- (void)setValueArray:(NSArray<MXWPieModel *> *)valueArray {
    _valueArray = [valueArray copy];
    [_valueArray enumerateObjectsUsingBlock:^(MXWPieModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.maxValue = obj.value > self.maxValue ? obj.value:self.maxValue;
    }];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    CGFloat width = self.bounds.size.width /(2.0* self.valueArray.count) - 0.5;
    CGFloat maxHeight = self.bounds.size.height;
    
    /** 画出边框 */
    UIBezierPath * path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(0, CGRectGetMaxY(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds))];
    [path setLineWidth:1];
    [[UIColor blackColor] set];
    [path stroke];
    
    /** 开始画柱状图 */
    [self.valueArray enumerateObjectsUsingBlock:^(MXWPieModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CGFloat x = (2*idx+1)*width;
        CGFloat height = obj.value * maxHeight / self.maxValue;
        CGFloat y = maxHeight - height;
        
        CGRect frame = CGRectMake(x, y, width, height-1);
        UIBezierPath * path = [UIBezierPath bezierPathWithRect:frame];
        [obj.color set];
        [path fill];
    }];
    
}

-(void)dealloc {
    NSLog(@"我被释放了MXWColumnarView");
}

@end
