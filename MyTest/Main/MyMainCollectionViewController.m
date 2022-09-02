//
//  MyMainCollectionViewController.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/2.
//

#import "MyMainCollectionViewController.h"
#import "MXWMainCell.h"
#import "MXWItemModel.h"
#import "MXWColockViewController.h"
#import "MXWPaintBoardViewController.h"
#import "MXWGuestureUnlockVC.h"



@interface MyMainCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (copy,nonatomic) NSArray * dataList;

@end


@implementation MyMainCollectionViewController
static NSString * const reuseIdentifier = @"Cell";


#pragma mark - === 懒加载===


-(NSArray *)dataList {
    if (!_dataList) {
        _dataList = [MXWItemModel loadDate];
    }
    return _dataList;
}


#pragma mark - === LifeCircle ===
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    self.clearsSelectionOnViewWillAppear = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
   //  Register cell classes
   // [self.collectionView registerClass:[MXWMainCell class] forCellWithReuseIdentifier:reuseIdentifier];
    /**
     强调注意事项： 当使用storyBoard 创建cell则不需要注册，如果注册会导致自定义类型失效。
     如果是通过xib创建 则需要使用xib来注册
     如果是自定义手写自定义类 则需要使用自定义类来注册。
     */
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/2.0-5;
    self.flowLayout.itemSize = CGSizeMake(width, width);
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 10;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;

}


#pragma mark -  segue Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MXWMainCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MXWItemModel * model = self.dataList[indexPath.item];
    cell.model = model;
    return  cell;
}


#pragma mark  - <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

/** item点击方法 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MXWItemModel * model = self.dataList[indexPath.item];
    UIViewController * VC = [self getViewControllerFromSB:@"Main" withID:model.VCID];

    /** 手势识别的是模态出现 其他的为压栈 */
    if ([VC isKindOfClass:[MXWGuestureUnlockVC class]]) {
        VC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController presentViewController:VC animated:YES completion:^{}];
    } else {
        [self.navigationController pushViewController:VC animated:YES];
    }

}


/** 从StoryBoard 中根据 标识符加载控制器 */
-(UIViewController *)getViewControllerFromSB:(NSString *)sbName withID:(NSString *)controllerID {
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:sbName bundle:[NSBundle mainBundle]];
    UIViewController * controller = [storyBoard instantiateViewControllerWithIdentifier:controllerID];
    return  controller;
}



@end
