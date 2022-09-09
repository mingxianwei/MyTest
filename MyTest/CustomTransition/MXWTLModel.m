//
//  MXWTLModel.m
//  MyTest
//
//  Created by 明先伟 on 2022/9/9.
//

#import "MXWTLModel.h"

@implementation MXWTLModel


- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}


+ (instancetype)tlModelWithDic:(NSDictionary *)dic {
    return  [[self alloc] initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%s===key= %@",__func__,key);
}



@end
