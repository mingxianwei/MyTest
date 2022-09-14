//
//  MXWPaintBoardView.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/4.
//

#import "MXWPaintBoardView.h"


@interface MXWPaintBoardView ()


@property (nonatomic,strong) NSMutableArray <MXWBezierPath *>* pathArry;

@end

@implementation MXWPaintBoardView


-(NSMutableArray<MXWBezierPath *> *)pathArry {
    if (!_pathArry) {
        _pathArry = [NSMutableArray array];
    }
    return _pathArry;
}

- (void)setPathwithArry:(NSArray<MXWBezierPath *> * _Nonnull)pathArry {
    self.pathArry = [pathArry mutableCopy];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    for (MXWBezierPath *path in self.pathArry) {
        [path setLineWidth:path.lineWidth];
        [path setLineCapStyle:kCGLineCapRound];
        [path setLineJoinStyle:kCGLineJoinRound];
        [path.color set];
//        [path dicFromBezierPath];
        [path stroke];
    }
    
}

#pragma mark - === Touch ===
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //1. 获取到触摸的点
    
    UITouch *touch = [touches anyObject];
    CGPoint  point = [touch locationInView:self];
    
    MXWBezierPath * path = [[MXWBezierPath alloc] init];
    path.lineWidth  = self.lineWith;
    [path moveToPoint:point];
    path.color = self.lineColor;
    [self.pathArry addObject:path];

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint  point = [touch locationInView:self];
    MXWBezierPath * path = self.pathArry.lastObject;
    [path addLineToPoint:point];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - === SEL ===

/** 将曲线转换成字典数组 */
- (NSArray *)arrayWithMXWBezierPathArray {
    
    if(self.pathArry.count <= 0) {
        return nil;
    }
    
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:self.pathArry.count];
    for (MXWBezierPath *path in self.pathArry) {
        NSDictionary * dic = [path dicFromBezierPath];
        [array addObject:dic];
    }
    return array;
}


- (void)reback {
    [self.pathArry removeLastObject];
    [self setNeedsDisplay];
}

- (void)clear {
    [self.pathArry removeAllObjects];
    [self setNeedsDisplay];
}

- (void)eraser {
    self.lineColor = self.backgroundColor;
}

- (void)saveToImage {
    
    //1、开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    
    //3、获取图片上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //4、截图
    [self.layer renderInContext:ref];
    
    //5、获取图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();

    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
    //2 、关闭图片上下文
    UIGraphicsEndImageContext();
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"保存完成");
    
}


@end
