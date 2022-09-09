//
//  MXWTLViewModel.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import "MXWTLViewModel.h"

@implementation MXWTLViewModel

- (instancetype)initWithModel:(MXWTLModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return  self;
}

///** 重写set 方法来计算行高 */
//-(void)setModel:(MXWTLModel *)model {
//    _model = model;
//    _cellHeight = [self caculateHeightWithModel:model];
//}

//
///** 计算行高 */   行高的计算应该由Cell 自己来完成。然后存储到ViewModel 中
//-(CGFloat)caculateHeightWithModel:(MXWTLModel *)model {
//    /** 头像高度 */
//    CGFloat height =  50;
//
//    /** 文字和图像间距 */
//    height += 10;
//
//    /** 文字高度 */
//    height += 147;
//
//    /** 图片视图高度 */
//    height += 206;
//
//    return height;
//}


+ (NSArray *)getDemoDataArray {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"time_line_data" ofType:@".plist"];
    NSArray * array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray * objArray = [NSMutableArray arrayWithCapacity:5];
    [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        MXWTLModel * model =  [MXWTLModel tlModelWithDic:obj];
        MXWTLViewModel * viewModel = [[self alloc] initWithModel:model];
        
        [objArray addObject:viewModel];
    }];
    
    return [objArray copy];;
}

@end
