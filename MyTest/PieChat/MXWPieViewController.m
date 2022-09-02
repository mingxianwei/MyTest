//
//  MXWPieViewController.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/2.
//

#import "MXWPieViewController.h"
#import "MXWPieView.h"
#import "MXWColumnarView.h"

@interface MXWPieViewController ()

@property (strong, nonatomic) IBOutlet MXWPieView *pieView;

@property (weak, nonatomic) IBOutlet MXWColumnarView *columView;



@end

@implementation MXWPieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDataForView];
}

/** 给 PieView 设置数据 */
- (void)setDataForView {
    
    
    MXWPieModel * model1 = [MXWPieModel mxwPieModelWithTittle:@"玉米" andValue:200 andColor:UIRandomColor];
    MXWPieModel * model2 = [MXWPieModel mxwPieModelWithTittle:@"高粱" andValue:300 andColor:UIRandomColor];
    MXWPieModel * model3 = [MXWPieModel mxwPieModelWithTittle:@"小麦" andValue:100 andColor:UIRandomColor];
    MXWPieModel * model4 = [MXWPieModel mxwPieModelWithTittle:@"大豆" andValue:500 andColor:UIRandomColor];
    MXWPieModel * model5 = [MXWPieModel mxwPieModelWithTittle:@"棉花" andValue:800 andColor:UIRandomColor];
    
    /** 设置饼状图数据 */
    self.pieView.startArc = -M_PI_2;
    self.pieView.valueArray = @[model1,model2,model3,model4,model5];
   
    /** 设置柱状图的数值数组 */
    self.columView.valueArray = @[model1,model2,model3,model4,model5];
}



@end
