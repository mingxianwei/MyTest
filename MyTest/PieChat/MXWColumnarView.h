//
//  MXWColumnarView.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/2.
//

#import <UIKit/UIKit.h>
#import "MXWPieView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXWColumnarView : UIView

/** 传入的 数组  */
@property(nonatomic, copy) NSArray <MXWPieModel *> *valueArray;


@end

NS_ASSUME_NONNULL_END
