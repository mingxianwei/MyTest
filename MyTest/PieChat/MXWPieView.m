//
//  MXWPieView.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/1.
//

#import "MXWPieView.h"

@interface MXWPieView ()

/** 数组的值的和 */
@property (nonatomic, assign) CGFloat totalValue;


@end

@implementation MXWPieView


- (void)setValueArray:(NSArray<MXWPieModel *> *)valueArray {
    _valueArray = [valueArray copy];
    [_valueArray enumerateObjectsUsingBlock:^(MXWPieModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.totalValue += obj.value;
    }];
    
    [self setNeedsDisplay];
}



- (void)drawRect:(CGRect)rect {
    
    //1 确定圆心和半径 起始点位置
    CGPoint point = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    CGFloat r = MIN(self.bounds.size.width-4,self.bounds.size.height-4)/2.0 ;
    __block CGFloat startArc = self.startArc;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:point radius:r+1 startAngle:0 endAngle:2*M_PI clockwise:1];
    [[UIColor blackColor] setStroke];
    [path setLineWidth:1.0];
    [path stroke];
    
    
    [self.valueArray enumerateObjectsUsingBlock:^(MXWPieModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat endArc = startArc + (2 * M_PI *obj.value)/self.totalValue;
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:point radius:r startAngle:startArc endAngle:endArc clockwise:1];
        MXWPieModel * model = self.valueArray[idx];
        [model.color set];
        [path addLineToPoint:point];

        // 设置路径为填充
        [path fill];
        startArc = endArc;
    }];

}

-(void)dealloc {
    NSLog(@"我被释放了MXWPieView");
}

@end
