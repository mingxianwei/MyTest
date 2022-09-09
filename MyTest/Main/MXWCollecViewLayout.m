//
//  MXWCollecViewLayout.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import "MXWCollecViewLayout.h"


#define kLayoutSectInsetMarginLet 10
#define kLayoutSectinsetMarginTop 10
#define kLayoutitemNumberOfRows   3

@interface MXWCollecViewLayout ()

@property (nonatomic, strong)NSMutableArray * attrArray;
@property (nonatomic, assign) CGSize conternSize;

@end


@implementation MXWCollecViewLayout


- (NSMutableArray *)attrArray {
    if (nil == _attrArray ) {
        _attrArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _attrArray;
}


- (void)prepareLayout {
    [super prepareLayout];
    
    self.minimumLineSpacing = kLayoutSectInsetMarginLet;
    self.minimumInteritemSpacing = kLayoutSectInsetMarginLet;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(kLayoutSectInsetMarginLet, kLayoutSectinsetMarginTop, kLayoutSectInsetMarginLet, kLayoutSectinsetMarginTop);
    
    [self.attrArray removeAllObjects];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int i = 0; i < sectionCount; i++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j< itemCount; j++) {
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes * attr = [self layoutAttributesForItemAtIndexPath:indexpath];
            [self.attrArray addObject:attr];
        }
    }
    
}

-(NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return  self.attrArray;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
   
    CGFloat smalItemWidth = (self.collectionView.frame.size.width - 4 * self.minimumLineSpacing )/kLayoutitemNumberOfRows;
    CGFloat bigItemWidth = smalItemWidth * 2+ self.minimumLineSpacing;
    
    if (indexPath.section == 0 && indexPath.item == 0) {
//        attrs.size = CGSizeMake(bigItemWidth , bigItemWidth);
        attrs.frame = CGRectMake(kLayoutSectInsetMarginLet, kLayoutSectinsetMarginTop, bigItemWidth, bigItemWidth);
    } else if(indexPath.section == 0 && indexPath.item == 1) {
        attrs.size = CGSizeMake(smalItemWidth, smalItemWidth);
        attrs.frame = CGRectMake(kLayoutSectInsetMarginLet+bigItemWidth+self.minimumLineSpacing, self.minimumInteritemSpacing, smalItemWidth , smalItemWidth);
    } else if (indexPath.section == 0 && indexPath.item == 2) {
        attrs.frame = CGRectMake(kLayoutSectInsetMarginLet+bigItemWidth+self.minimumLineSpacing, kLayoutSectinsetMarginTop+smalItemWidth+self.minimumInteritemSpacing, smalItemWidth , smalItemWidth);
    } else {
        /** 其他视图  */
        NSInteger row = indexPath.item/3;
        NSInteger clum = indexPath.item %3;
        CGFloat x = kLayoutSectInsetMarginLet+ clum*(smalItemWidth+self.minimumInteritemSpacing);
        CGFloat y = bigItemWidth+kLayoutSectinsetMarginTop + (row-1) *(self.minimumLineSpacing+smalItemWidth) + self.minimumInteritemSpacing;
        attrs.frame = CGRectMake(x, y, smalItemWidth , smalItemWidth);
        
        CGFloat maxY = CGRectGetMaxY(attrs.frame) + kLayoutSectinsetMarginTop ;
        
        self.conternSize = CGSizeMake(self.collectionView.bounds.size.width, maxY);
        
    }
    return attrs;
}


- (CGSize)collectionViewContentSize {

    return self.conternSize;
}



@end
