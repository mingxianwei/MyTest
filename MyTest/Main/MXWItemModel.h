//
//  MXWIteamModel.h
//  MyTest
//
//  Created by 明先伟 on 2022/8/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXWItemModel : NSObject

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic, copy) NSString *tittle;
// 目的控制器的 标识符
@property (nonatomic, copy) NSString *VCID;

+(instancetype)iteamModelWithDic:(NSDictionary *)dic;

+(NSArray *)loadDate;

@end

NS_ASSUME_NONNULL_END
