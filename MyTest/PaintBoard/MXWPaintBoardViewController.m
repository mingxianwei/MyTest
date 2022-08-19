//
//  MXWPaintBoardViewController.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/4.
//

#import "MXWPaintBoardViewController.h"
#import "MXWPaintBoardView.h"

@interface MXWPaintBoardViewController ()
@property (weak, nonatomic) IBOutlet MXWPaintBoardView *myPaintBoardView;



@end

@implementation MXWPaintBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绘画板";
    [self.navigationItem.leftBarButtonItem setTitle:@"返回"];
    self.myPaintBoardView.lineColor = [UIColor blackColor];
    self.myPaintBoardView.lineWith = 10;
    [self grenBtnClick:nil];
    
}



- (IBAction)sliderValueChanged:(UISlider *)sender{
    
    self.myPaintBoardView.lineWith = sender.value;
}

- (IBAction)grenBtnClick:(id)sender {
    self.myPaintBoardView.lineColor = [UIColor colorWithRed:115/255.0 green:250/255.0 blue:111/225.0 alpha:1];
}


- (IBAction)blueBtnClick:(id)sender {
    self.myPaintBoardView.lineColor = [UIColor colorWithRed:93/255.0 green:122/255.0 blue:248/225.0 alpha:1];
}


- (IBAction)orangeBtnClick:(id)sender {
    self.myPaintBoardView.lineColor = [UIColor colorWithRed:232/255.0 green:130/255.0 blue:108/225.0 alpha:1];
}



- (IBAction)clearBtnClick:(id)sender {
    [self.myPaintBoardView clear];
}


- (IBAction)rebackBtnClick:(id)sender {
    [self.myPaintBoardView reback];
}


- (IBAction)eraserBtnClick:(id)sender {
    [self.myPaintBoardView eraser];
}



- (IBAction)saveBtnClick:(id)sender {
    [self.myPaintBoardView saveToImage];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
