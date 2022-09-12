//
//  MXWTimeLineCell.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import <UIKit/UIKit.h>
#import "MXWTLViewModel.h"
#import "MXWPotoBrowserTransAnimat.h"

NS_ASSUME_NONNULL_BEGIN


/** 选中图片 通知传值 */
#define kSelectedImageNotifacation  @"kSelectedImageNotifacation"
#define kSelectedImageNotifacationIndexPathKey @"kSelectedImageNotifacationIndexPathKey"
#define kSelectedImageNotifacationUrlArrayKey  @"kSelectedImageNotifacationUrlArrayKey"




@interface MXWTimeLineCell : UITableViewCell <MXWPhotoBrowserPresentedDelegate>


@property (nonatomic, strong) MXWTLViewModel *viewModel;

/** 提前计算Cell 高度并缓存 */
+(CGFloat)caculateRowHeighWithViewModel:(MXWTLViewModel *)viewModel;

/** 提前计算 文本高度并缓存 */
+(CGFloat)caculateHeighWithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
