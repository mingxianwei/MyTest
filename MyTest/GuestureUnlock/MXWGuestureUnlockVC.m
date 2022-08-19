//
//  MXWGuestureUnlockVC.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/18.
//

#import "MXWGuestureUnlockVC.h"
#import "MXWGuestureView.h"


#define KTipesNomal @"请输入手势密码"
#define KTipesCorrect @"手势密码正确"
#define KTipesErro @"密码错误请重新输入"

@interface MXWGuestureUnlockVC ()

@property (weak, nonatomic) IBOutlet MXWGuestureView *guestureView;
@property (weak, nonatomic) IBOutlet UILabel *tipsLable;



@end

@implementation MXWGuestureUnlockVC




#pragma mark - === 按钮响应事件 ===
- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // 用图片填充背景色。
    UIImage * image = [UIImage imageNamed:@"HomeButtomBG"];
    self.view.layer.backgroundColor  = [UIColor colorWithPatternImage:image].CGColor;
    
    __weak typeof(self) weakSelf = self;
    [self.guestureView setChackPasswordBlock:^BOOL(NSString * _Nonnull password) {
        if ([password isEqualToString:@"0125"]) {
            weakSelf.tipsLable.text = KTipesCorrect;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.25* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [weakSelf closeButtonClicked:nil];
            });
            return YES;
        } else {
            weakSelf.tipsLable.text = KTipesErro;
            return NO;
        }
    }];
    
    [self.guestureView setAfterClearBlock:^{
        weakSelf.tipsLable.text = KTipesNomal;
    }];
 
}

/**
 应当在这个位置设置子控件farme 和位置，否则在屏幕横屏之后将会位置不正常。
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    //设置手势视图的frame
    CGFloat width = MIN(self.view.bounds.size.width, self.view.bounds.size.height);
    self.guestureView.bounds = CGRectMake(0, 0, width, width);
    self.guestureView.center = CGPointMake(self.view.center.x, self.view.center.y+20);
    self.tipsLable.center = CGPointMake(self.guestureView.center.x,CGRectGetMinY(self.guestureView.frame)-10);
}


-(void)dealloc {
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
