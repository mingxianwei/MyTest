//
//  MXWPieModel.m
//  MyTest
//
//  Created by ζεδΌ on 2022/9/1.
//

#import "MXWPieModel.h"

@implementation MXWPieModel

+ (instancetype)mxwPieModelWithTittle:(NSString *)tittle andValue:(CGFloat)value andColor:(UIColor *)color {
    MXWPieModel * model = [MXWPieModel new];
    model.tittle = tittle;
    model.value = value;
    model.color = color;
    return  model;
}

@end
