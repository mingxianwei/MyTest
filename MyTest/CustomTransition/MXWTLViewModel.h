//
//  MXWTLViewModel.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MXWTLModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXWTLViewModel : NSObject

/** 在设置mode 属性之后自动计算和缓存cell 行高 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 缓存 计算文本高度 */
@property (nonatomic, assign) CGFloat textHeight;

@property (nonatomic, strong) MXWTLModel *model;


- (instancetype)initWithModel:(MXWTLModel *)model;


+ (NSArray *)getDemoDataArray;

@end

NS_ASSUME_NONNULL_END
