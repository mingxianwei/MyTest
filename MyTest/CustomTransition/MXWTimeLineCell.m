//
//  MXWTimeLineCell.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import "MXWTimeLineCell.h"
#import "MXWTLCollectionView.h"

@interface MXWTimeLineCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@property (weak, nonatomic) IBOutlet MXWTLCollectionView *imageCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *imageCollectionViewLayout;


@end

@implementation MXWTimeLineCell

+(CGFloat)caculateRowHeighWithViewModel:(MXWTLViewModel *)viewModel{
    /** Cell 自己计算行高 应该在Cell 的控制器中加载数据时候就缓存行高 */
    /** 头像高度 */
    CGFloat height =  50;

    /** 文字和图像间距 */
    height += 10;

    /** 文字高度 */
    height += 147;

    /** 图片视图高度 */
    height += 206;

    return height;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageCollectionView.delegate  = self;
    self.imageCollectionView.dataSource = self;
    
    self.imageCollectionViewLayout.minimumLineSpacing = 5;
    self.imageCollectionViewLayout.minimumInteritemSpacing = 5;

}

-(void)layoutSubviews {
    [super layoutSubviews];
    
   CGFloat width =  (self.contentView.bounds.size.width - 2* self.imageCollectionViewLayout.minimumLineSpacing)/3;
   self.imageCollectionViewLayout.itemSize = CGSizeMake(width, width);
    
    
}


-(void)setViewModel:(MXWTLViewModel *)viewModel {
    /** 赋值 */
    _viewModel = viewModel;
    
    /** 设置数据 */
    self.nameLable.text = viewModel.model.name;
    self.contentLable.text = viewModel.model.content;
    
}


#pragma mark - === CollectionViewDelegate ===






#pragma mark - === CollectionViewDataSource ===

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.model.imageArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    return cell;
}


@end
