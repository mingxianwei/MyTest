//
//  MXWMainCell.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/17.
//

#import "MXWMainCell.h"
#import "MXWItemModel.h"

@interface MXWMainCell ()

@property (weak, nonatomic) IBOutlet UIImageView *myimageView;

@property (weak, nonatomic) IBOutlet UILabel *tittleLable;

@end


@implementation MXWMainCell

/** set 方法 */
- (void)setModel:(MXWItemModel *)model {
    _model = model;
    self.myimageView.image = [UIImage imageNamed:model.imageName];
    self.tittleLable.text = model.tittle;
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 10;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.masksToBounds = YES;
}



@end
