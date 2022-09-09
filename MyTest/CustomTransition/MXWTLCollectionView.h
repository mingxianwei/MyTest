//
//  MXWTLCollectionView.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface ImageCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageUrl;

@end






@interface MXWTLCollectionView : UICollectionView

@property (nonatomic, copy) NSArray *imageArray;


@end

NS_ASSUME_NONNULL_END
