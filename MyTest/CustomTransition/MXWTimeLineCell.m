//
//  MXWTimeLineCell.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import "MXWTimeLineCell.h"
#import "MXWTLCollectionView.h"
#import "UIView+MXWFrame.h"
#import <SDWebImage/SDWebImage.h>

#import "MXWPotoBrowserTransAnimat.h"


#define kImageCountInRow  3
#define kImageMargin      5
#define kMaxShowImageCount 9



@interface MXWTimeLineCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@property (weak, nonatomic) IBOutlet MXWTLCollectionView *imageCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *imageCollectionViewLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageCollectinViewHeighConstr;


@end

@implementation MXWTimeLineCell


+(CGFloat)caculateHeighWithString:(NSString *)str {
    CGFloat height = 0;
    
    if (str.length > 0) {
        //1.1最大允许绘制的文本范围
        CGSize size = CGSizeMake(ScreenWidth - 40, 2000);
        
        //1.4配置属性字典
        UIFont * font = [UIFont systemFontOfSize:17];
        NSDictionary *dic = @{NSFontAttributeName:font};

        //2.计算
        height += [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    }
        
    return height;
}

+(CGFloat)caculateRowHeighWithViewModel:(MXWTLViewModel *)viewModel{
    /** Cell 自己计算行高 应该在Cell 的控制器中加载数据时候就缓存行高 */
   
    /** 头像高度 */
    CGFloat height = 10;
    height +=  50;
    
    if(viewModel.model.content.length > 0){
        /** 文本和 图像间距10 */
        height += 10;
        height += viewModel.textHeight;
    }
    
    /** 图片视图高度 */
    CGFloat imageCount = viewModel.model.imageArray.count > kMaxShowImageCount ? kMaxShowImageCount : viewModel.model.imageArray.count *1.0;
    if (imageCount > 0) {
        
        /** 图片距离 文本 15 */
        height += 15;
        
        NSInteger clum = ceil(imageCount/kImageCountInRow);
        /** -40 因为Cell ConternView 距离屏幕两边的宽度是 20  */
        CGFloat width =  (ScreenWidth - 40 - (kImageCountInRow-1)* kImageMargin)/kImageCountInRow;
        height+= (width+ kImageMargin) * clum - kImageMargin;
    }

    /** 计算多15 让cell 之间有个空隙 */
    height +=10;
    
    return height;
}



/** 初始化 视图 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.imageCollectionView.delegate  = self;
    self.imageCollectionView.dataSource = self;
    
    self.imageCollectionView.bounces = NO;
    self.imageCollectionView.showsVerticalScrollIndicator = NO;
    self.imageCollectionView.showsHorizontalScrollIndicator = NO;
    
    self.imageCollectionViewLayout.minimumLineSpacing = kImageMargin ;
    self.imageCollectionViewLayout.minimumInteritemSpacing = kImageMargin;
    
    
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;

}


/** 视图布局 */
-(void)layoutSubviews {
    [super layoutSubviews];
   
    /** 设置文本视图的高度 */
    self.contentLable.height = self.viewModel.textHeight;
    /** 设置 图片视图的Frame */
    CGFloat width =  (ScreenWidth - 40 - (kImageCountInRow-1)* kImageMargin)/kImageCountInRow;
    self.imageCollectionViewLayout.itemSize = CGSizeMake(width, width);
    [self.imageCollectionView setNeedsLayout];
    
    [self.imageCollectionView reloadData];
    
}


-(void)setViewModel:(MXWTLViewModel *)viewModel {
    /** 赋值 */
    _viewModel = viewModel;
    /** 设置数据 */
    self.nameLable.text = viewModel.model.name;
    self.contentLable.text = viewModel.model.content;

    /** 设置 图片视图的Frame */
    CGFloat width =  (ScreenWidth - 40 - (kImageCountInRow-1)* kImageMargin)/kImageCountInRow;
//    self.imageCollectionViewLayout.itemSize = CGSizeMake(width, width);
    
    CGFloat imageCount = self.viewModel.model.imageArray.count*1.0;
    imageCount =  imageCount > kMaxShowImageCount ? kMaxShowImageCount: imageCount ;
    if (imageCount > 0) {
        NSInteger clum = ceil (imageCount/kImageCountInRow) ;
        CGFloat height =(width+kImageMargin) * clum -kImageMargin;
        self.imageCollectinViewHeighConstr.constant = height;
    } else {
        self.imageCollectinViewHeighConstr.constant = 0;
    }
}


#pragma mark - === CollectionViewDelegate ===

/** 选中了图片 时候 需要 回传 数据 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /** 选中之后就发送通知 */
    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectedImageNotifacation object:self userInfo:@{kSelectedImageNotifacationIndexPathKey:indexPath,kSelectedImageNotifacationUrlArrayKey:self.viewModel.model.imageArray}];
}




#pragma mark - === CollectionViewDataSource ===

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger imageCount = self.viewModel.model.imageArray.count;
    imageCount =  imageCount > kMaxShowImageCount ? kMaxShowImageCount: imageCount;
    return imageCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    cell.imageUrl = self.viewModel.model.imageArray[indexPath.row];
    return cell;
}



#pragma mark - === MXWPhotoBrowserPresentedDelegate ===

/** 展示转场动画的图片视图 */
- (UIImageView *)imageViewFromPresentAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell * cell = (ImageCell *)[self.imageCollectionView cellForItemAtIndexPath:indexPath];
    NSString *stringUrl = cell.imageUrl;

    UIImageView * imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView sd_setImageWithURL:[NSURL URLWithString:stringUrl]];
    return imageView;
}

/** 专场动画图片的  初始位置 */
-(CGRect)fromRectAtPresentingVCAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [self.imageCollectionView cellForItemAtIndexPath:indexPath];
    
  CGRect fromRect =   [self.imageCollectionView convertRect:cell.frame toView:[UIApplication sharedApplication].delegate.window];
    return  fromRect;
}

/** 专场动画的图片 最终位置 */
-(CGRect)toRectAtPresentedVCAtIndexpath:(NSIndexPath *)indexPath{
    NSString * url = self.viewModel.model.imageArray[indexPath.item];
    SDImageCache* cache = [SDImageCache sharedImageCache]; //此方法会先从memory中取。
    UIImage *image = [cache imageFromDiskCacheForKey:url];

    CGFloat height = image.size.height* ScreenWidth/image.size.width;
    
    if (height > ScreenHeight) {
        return CGRectMake(0, 0, ScreenWidth, height);
    } else {
        CGFloat y = (ScreenHeight - height)* 0.5;
        return CGRectMake(0, y, ScreenWidth, height);
    }
    
}



@end
