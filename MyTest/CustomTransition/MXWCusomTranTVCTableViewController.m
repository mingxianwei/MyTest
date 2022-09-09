//
//  MXWCusomTranTVCTableViewController.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import "MXWCusomTranTVCTableViewController.h"
#import "MXWTimeLineCell.h"
#import "MXWTLViewModel.h"

@interface MXWCusomTranTVCTableViewController ()

@property (nonatomic, copy) NSArray<MXWTLViewModel *> *viewModelArray;

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


- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)dealloc {
    NSLog(@"我被释放了%@",self.description);
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
