//
//  MXWPotoBrowserCell.h
//  MyTest
//
//  Created by ζεδΌ on 2022/9/10.
//

#import <UIKit/UIKit.h>

@interface MXWPotoBrowserCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageUrlString;

@property (strong, nonatomic)  UIImageView *imageView;

@property (strong, nonatomic)  UIScrollView *scrollView;


@property (nonatomic, copy) void(^tapScrollViewCallBack)(void);

@property (nonatomic, copy) void(^longPressCallBack)(UIImage * image);

@end
