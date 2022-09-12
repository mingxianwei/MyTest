//
//  MXWPhotoBrowserVCViewController.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/10.
//




#import "MXWPhotoBrowserVC.h"
#import "MXWPotoBrowserCell.h"
#import "UIView+MXWFrame.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface MXWPhotoBrowserVC () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic)  UICollectionView *potoCollectionView;
@property (strong, nonatomic)  UIPageControl *pageControl;
@property (strong, nonatomic)  UICollectionViewFlowLayout *collectionViewLayout;

@end

@implementation MXWPhotoBrowserVC

static NSString * const cellResueID = @"photoBrowserCell";




/** 初始化UI */
- (void)setupUI {
    self.view.backgroundColor = [UIColor blackColor];
    
    
    /** 初始化UICollectionView */
    self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.potoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
    [self.view addSubview:self.potoCollectionView];
     self.potoCollectionView.backgroundColor = [UIColor blackColor];
    [self.potoCollectionView registerClass:[MXWPotoBrowserCell class] forCellWithReuseIdentifier:cellResueID];
    
    /** 准备CollectionView */
    self.potoCollectionView.delegate = self;
    self.potoCollectionView.dataSource = self;
    self.potoCollectionView.showsVerticalScrollIndicator = NO;
    self.potoCollectionView.showsHorizontalScrollIndicator = NO;
    self.potoCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.potoCollectionView.pagingEnabled = YES;
    self.potoCollectionView.bounces = NO;
    
    /** 布局 */
    self.collectionViewLayout.itemSize = self.potoCollectionView.bounds.size;
    self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionViewLayout.minimumLineSpacing = 0;
    self.collectionViewLayout.minimumInteritemSpacing = 0;
    
    
    
    /** 准备PageControl */
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.height-100, self.view.width, 30)];
    self.pageControl.numberOfPages = self.imageUrlArray.count;
    self.pageControl.currentPage = self.indexPath.row;
    [self.view addSubview:self.pageControl];
    

    

    
}

#pragma mark - === LifeClicle ===

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)loadView {
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.potoCollectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

-(void)dealloc {
    NSLog(@"我被释放了%@",self.description);
}

#pragma mark - ===CollectionViewDataSource/ CollectionViewDelegate ===
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageUrlArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MXWPotoBrowserCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellResueID forIndexPath:indexPath];
    cell.imageUrlString = self.imageUrlArray[indexPath.item];
    
    __weak typeof(self) weakSelf = self;
    [cell setTapScrollViewCallBack:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [cell setLongPressCallBack:^(UIImage *image) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"是否保存图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {
            UIImageWriteToSavedPhotosAlbum(image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }];
        
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = index;
}

#pragma mark - === imagePickerController: didFinishPickingMediaWithInfo ===

- (void)image:(UIImage *)image
    didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    if (!error ) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.minShowTime = 3;
        hud.label.text = @"保存成功";
        hud.mode = MBProgressHUDModeText;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }
}



#pragma mark - === MXWPhotoBrowserDismissdDelegate ===

/** 展示转场动画的图片视图 */
-(UIImageView *)imageViewForDissmiss {
    UIImageView * imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    
    MXWPotoBrowserCell * cell = (MXWPotoBrowserCell *)self.potoCollectionView.visibleCells.lastObject;
    imageView.image = cell.imageView.image;
    imageView.frame = [cell.scrollView convertRect:cell.imageView.frame toView:[UIApplication sharedApplication].delegate.window];
    
    return imageView;
}

-(NSIndexPath *)indexPathForDismiss {
    return self.potoCollectionView.indexPathsForVisibleItems.lastObject;
}

@end
