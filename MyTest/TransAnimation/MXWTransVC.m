//
//  MXWTransVCViewController.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/2.
//

#import "MXWTransVC.h"

@interface MXWTransVC ()

@property (nonatomic, copy) NSArray<UIImage *> *imageArray;

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *transType;

@end


@implementation MXWTransVC

#pragma mark - === 懒加载 ===
- (NSArray<UIImage *> *)imageArray {
    if (_imageArray == nil) {
        UIImage * image1 = [UIImage imageNamed:@"111.jpg"];
        UIImage * image2 = [UIImage imageNamed:@"222.jpg"];
        UIImage * image3 = [UIImage imageNamed:@"333.jpg"];
        UIImage * image4 = [UIImage imageNamed:@"444.jpg"];
        _imageArray = @[image1,image2,image3,image4];
    }
    return _imageArray;
}

/** 重写set方法 并修改图片 */
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    self.myImageView.image = self.imageArray[_currentIndex];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.transType = @"cube";
    self.currentIndex = 0;
    self.myImageView.image = self.imageArray[self.currentIndex];
}


- (IBAction)imageChange:(UISwipeGestureRecognizer*)sender {
    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.currentIndex = (self.currentIndex + 1) % self.imageArray.count;
        CATransition * trans = [CATransition new];
        trans.type = self.transType;
        trans.subtype =  kCATransitionFromRight;
        [self.myImageView.layer addAnimation:trans forKey:nil];

    } else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        self.currentIndex = (self.currentIndex - 1 + self.imageArray.count) % self.imageArray.count;
        CATransition * trans = [CATransition new];
        trans.type = self.transType;
        trans.subtype =  kCATransitionFromLeft;
        [self.myImageView.layer addAnimation:trans forKey:nil];
    }
    
}

/** 点击按钮之后将按钮tittle 设置为动销类型 */
- (IBAction)transTypeSelected:(UIButton *)sender {
    self.transType = sender.titleLabel.text;
}

@end
