//
//  MXWCusomTranTVCTableViewController.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import "MXWCusomTranTVCTableViewController.h"
#import "MXWTimeLineCell.h"
#import "MXWTLViewModel.h"
#import "MXWPhotoBrowserVC.h"
#import "MXWPotoBrowserTransAnimat.h"

@interface MXWCusomTranTVCTableViewController ()

@property (nonatomic, copy) NSArray<MXWTLViewModel *> *viewModelArray;


@property (nonatomic,strong) MXWPotoBrowserTransAnimat * transAnimatorDelegate;


@end

@implementation MXWCusomTranTVCTableViewController

#pragma mark - === LifeClicle ===

/** 懒加载 */
- (NSArray<MXWTLViewModel *> *)viewModelArray {
    if (_viewModelArray == nil) {
        _viewModelArray = [MXWTLViewModel getDemoDataArray];
        /** 提前计算行高 和 文本高度 并缓存 */
        [_viewModelArray enumerateObjectsUsingBlock:^(MXWTLViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.textHeight = [MXWTimeLineCell caculateHeighWithString:obj.model.content];
            obj.cellHeight = [MXWTimeLineCell caculateRowHeighWithViewModel:obj];
            
        }];
    }
    return _viewModelArray;
}

- (MXWPotoBrowserTransAnimat *)transAnimatorDelegate {
    if (_transAnimatorDelegate == nil) {
        _transAnimatorDelegate = [MXWPotoBrowserTransAnimat new];
    }
    return _transAnimatorDelegate;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 注册通知 */
    
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:kSelectedImageNotifacation object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        NSIndexPath * indexPath = note.userInfo[kSelectedImageNotifacationIndexPathKey];
        NSArray * array = note.userInfo[kSelectedImageNotifacationUrlArrayKey];
        
        MXWPhotoBrowserVC *VC = [MXWPhotoBrowserVC new];
        VC.indexPath = indexPath;
        VC.imageUrlArray = array;
        VC.modalPresentationStyle = UIModalPresentationCustom;
        VC.transitioningDelegate = weakSelf.transAnimatorDelegate;
        
        weakSelf.transAnimatorDelegate.presentDelegate = (MXWTimeLineCell *)note.object;
        weakSelf.transAnimatorDelegate.dismissDelegate = VC;
        weakSelf.transAnimatorDelegate.indexPath = indexPath;
        
        /** 模态弹出视图 */
        [weakSelf presentViewController:VC animated:YES completion:^{}];
    
    }];
    
}


-(void)dealloc {
    NSLog(@"我被释放了%@",self.description);
    
    /** 通知要被释放 */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.viewModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXWTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.viewModel = self.viewModelArray[indexPath.row];
    [cell setNeedsLayout];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.viewModelArray[indexPath.row].cellHeight;
}


@end
