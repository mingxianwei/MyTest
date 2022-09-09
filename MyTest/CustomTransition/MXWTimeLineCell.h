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

+(CGFloat)caculateRowHeighWithViewModel:(MXWTLViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
