//
//  MXWGuestureView.h
//  MyTest
//
//  Created by 明先伟 on 2022/8/18.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface MXWGuestureView : UIView
@property (nonatomic, copy) BOOL(^ChackPasswordBlock)(NSString *password);
@property (nonatomic, copy) void (^afterClearBlock)(void);

@end

NS_ASSUME_NONNULL_END
