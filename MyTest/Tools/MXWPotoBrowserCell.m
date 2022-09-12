//
//  MXWPotoBrowserCell.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/10.
//

#import "MXWPotoBrowserCell.h"
#import <SDWebImage/SDWebImage.h>
#import "UIView+MXWFrame.h"

@interface MXWPotoBrowserCell ()<UIScrollViewDelegate>





@end


@implementation MXWPotoBrowserCell


#pragma mark - === SEL ===

- (void)tapScrollView {
    if (self.tapScrollViewCallBack) {
        self.tapScrollViewCallBack();
    }
}

- (void)longPressScrollView {
    if(self.longPressCallBack){
        self.longPressCallBack(self.imageView.image);
    }
}


-(void)dealloc {
    NSLog(@"释放了");
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
//        self.scrollView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.scrollView];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.scrollView addSubview:self.imageView] ;
        
        
        self.scrollView.delegate = self;
        self.scrollView.minimumZoomScale = 0.5;
        self.scrollView.maximumZoomScale = 2;
        
        
        /** scroview添加 单击手势和长安手势 */
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
        [self.scrollView addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressScrollView)];
        [self.scrollView addGestureRecognizer:longPress];
        
    }
    
    return self;
}

/** 恢复ScrollView 状态  */
- (void)restScrollView {
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.contentSize = CGSizeZero;
}

- (void)setImageUrlString:(NSString *)imageUrlString {
    _imageUrlString = imageUrlString;
    
    /** 滚动之后ScrollView 的状态改变 会影响Cell 复用效果这里需要重置 */
    [self restScrollView];
    
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 1;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        /** 设置图片大小 缩放 */
        self.imageView.size = CGSizeMake(self.scrollView.width, image.size.height * self.scrollView.width/image.size.width);
        /** 长图 */
        if (self.imageView.height > self.scrollView.height) {
            self.imageView.y = 0;
            self.scrollView.contentSize = self.imageView.size;
            
            self.scrollView.minimumZoomScale =  self.scrollView.height/ self.imageView.height;
            self.scrollView.maximumZoomScale = 2;
            
        /** 短图 */
        } else {
            self.scrollView.minimumZoomScale = 1;
            self.scrollView.maximumZoomScale = 2;
            //如果使用frame 调整位置 导致放大之后图片内容显示不全。
            //self.imageView.center = self.scrollView.center;
            self.imageView.y = 0;
            self.scrollView.contentSize = CGSizeZero;
            CGFloat topY = (self.scrollView.height - self.imageView.height)* 0.5;
            self.scrollView.contentInset = UIEdgeInsetsMake(topY, 0, 0, 0);
        }
        
    }];
}

#pragma mark - === ScrollviewDelegate ===

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return  self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    CGFloat offY = (scrollView.frame.size.height - view.frame.size.height)* 0.5;
    offY  = offY > 0 ? offY:0;
    
    CGFloat offX = (scrollView.frame.size.width - view.frame.size.width)*0.5;
    offX = offX >0 ? offX: 0;
    
    scrollView.contentInset = UIEdgeInsetsMake(offY, offX, 0, 0);
}



@end
