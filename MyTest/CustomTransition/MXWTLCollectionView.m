//
//  MXWTLCollectionView.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import "MXWTLCollectionView.h"
#import <SDWebImage/SDWebImage.h>


@interface ImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageVew;

@end


@implementation ImageCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.imageVew.layer.cornerRadius =3;
    [self.imageVew.layer masksToBounds];
    
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    
    NSURL* url = [NSURL URLWithString:imageUrl];
    [self.imageVew sd_setImageWithURL:url];
}

@end




@interface MXWTLCollectionView ()



@end



@implementation MXWTLCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    /** 这里开始初始化 自己的CollectionView */
}

@end
