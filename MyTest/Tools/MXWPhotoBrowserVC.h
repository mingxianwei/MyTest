//
//  MXWPhotoBrowserVCViewController.h
//  MyTest
//
//  Created by ζεδΌ on 2022/9/10.
//

#import <UIKit/UIKit.h>
#import "MXWPotoBrowserTransAnimat.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXWPhotoBrowserVC : UIViewController <MXWPhotoBrowserDismissdDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSArray *imageUrlArray;


@end

NS_ASSUME_NONNULL_END
