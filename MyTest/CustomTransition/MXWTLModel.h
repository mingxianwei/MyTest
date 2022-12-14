//
//  MXWTLModel.h
//  MyTest
//
//  Created by ζεδΌ on 2022/9/9.
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
