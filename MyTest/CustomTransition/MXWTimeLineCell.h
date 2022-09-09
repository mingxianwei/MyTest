//
//  MXWTimeLineCell.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import <UIKit/UIKit.h>
#import "MXWTLViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXWTimeLineCell : UITableViewCell


@property (nonatomic, strong) MXWTLViewModel *viewModel;

/** 提前计算Cell 高度并缓存 */
+(CGFloat)caculateRowHeighWithViewModel:(MXWTLViewModel *)viewModel;

/** 提前计算 文本高度并缓存 */
+(CGFloat)caculateHeighWithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
