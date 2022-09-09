//
//  MXWTLModel.h
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXWTLModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSArray *imageArray;


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)tlModelWithDic:(NSDictionary *)dic;




@end

NS_ASSUME_NONNULL_END
