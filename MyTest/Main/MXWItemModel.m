//
//  MXWIteamModel.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/17.
//

#import "MXWItemModel.h"

@implementation MXWItemModel

+(instancetype)iteamModelWithDic:(NSDictionary *)dic {
   MXWItemModel * item = [self new];
    [item setValuesForKeysWithDictionary:dic];
    return  item;
}

+(NSArray *)loadDate {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"item_data" ofType:@"plist"];
    NSArray * array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray * mutablearray = [NSMutableArray arrayWithCapacity:4];
    [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MXWItemModel * model =  [self iteamModelWithDic:obj];
        [mutablearray addObject:model];
    }];
    return  mutablearray.copy;
}

@end
