//
//  MXWPieView.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/1.
//

#import <UIKit/UIKit.h>
#import "MXWPieModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXWPieView : UIView

/** 传入的 数组  */
@property(nonatomic, copy) NSArray <MXWPieModel *> *valueArray;

/** 起始角度 */
@property (nonatomic, assign) CGFloat startArc;


@end

NS_ASSUME_NONNULL_END
