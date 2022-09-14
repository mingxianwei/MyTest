//
//  MXWBezierPath.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/4.
//

#import "MXWBezierPath.h"
#import "UIColor+Hex.h"

#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]


@implementation MXWBezierPath


static NSString * colorKey = @"color";
static NSString * lineWidthKey = @"width";
static NSString * pointsDicKey = @"points";
static NSString * moveTopointsArraykey = @"moveToPoints";

/** 根据字典初始化 BezierPath */
+(MXWBezierPath *)bezierPathFromDic:(NSDictionary *)dic{
    MXWBezierPath * path = [MXWBezierPath new];
    path.color = [UIColor colorWithHexString:dic[@"color"]];
    path.lineWidth = [dic[@"width"] floatValue];
    
    NSDictionary * pointDic = dic[@"points"];
    NSDictionary *pointdic = pointDic[@"moveToPoints"];
 
    if(pointdic == nil) {
        return  nil;
    } else {
        CGFloat x = [pointdic[@"x"] floatValue];
        CGFloat y = [pointdic[@"y"] floatValue];
        [path moveToPoint:CGPointMake(x, y)];
        NSArray * pointArray = pointDic[@"addLinetoPoints"];
        for (int i= 0; i< pointArray.count; i++) {
            NSDictionary *dic = pointArray[i];
            CGFloat x = [dic[@"x"] floatValue];
            CGFloat y = [dic[@"y"] floatValue];
            [path addLineToPoint:CGPointMake(x, y)];
        }
        return  path;
    }
}

/** 将贝塞尔曲线转化成字典 */
-(NSDictionary *)dicFromBezierPath{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString * colorString = [self.color hexadecimalFromUIColor];
    dic[@"color"] = colorString;
    dic[@"width"] = @(self.lineWidth);
    dic[@"points"] = [self pathDic];
    return  [dic copy];
}



/** 将 贝塞尔曲线转化成字典  最重要的是调用CGPathApply 方法 */
- (NSDictionary *)pathDic{
    NSMutableDictionary *path = [NSMutableDictionary dictionary];
    path[@"addLinetoPoints"] = [NSMutableArray array];
    path[@"moveToPoints"] =  @{@"x":@(0),@"y":@(0)};
    CGPathApply(self.CGPath, (__bridge void *)path, getPointsFromBezier);
    NSLog(@"%@",path);
    return [path copy];
}

/** 根据路径 拿到路径的点  */
void getPointsFromBezier(void *info,const CGPathElement *element){
    NSMutableDictionary *bezierPoints = (__bridge NSMutableDictionary *)info;
    CGPathElementType type = element->type;
    CGPoint points = *element->points;
    if (type == kCGPathElementMoveToPoint ) {
        bezierPoints[@"moveToPoints"] =  @{@"x":@(points.x),@"y":@(points.y)};
    } else if (type == kCGPathElementAddLineToPoint) {
        NSMutableArray * array =  bezierPoints[@"addLinetoPoints"] ;
        [array addObject:@{@"x":@(points.x),@"y":@(points.y)}];
    }
}




@end
