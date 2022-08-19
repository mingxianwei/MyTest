//
//  MXWSignalInstance.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/8.
//

#import "MXWSignalInstance.h"

@implementation MXWSignalInstance

/**  方法一
 
 +(instancetype)shareSignalInstance {
     static MXWSignalInstance * signalInstance= nil;
     //防止现成安全问题，这里加上同步锁
     @synchronized (self) {
         if (signalInstance == nil) {
             signalInstance = [[self alloc] init];
         }
     }
     return  signalInstance;;
 }
 
 */


/**
 这个是单例的 第二种写法 。
 
 需要注意一下两点   1 声明一个静态变量 类似懒加载判断静态变脸是否有值，这是保证 程序运行中 内存中单例对象是否为唯一的关键
 
 第二， dispatch_onece 方法中有一个 tocken指针，这个地方需要取地址符，将变量转换成执政，以便在 方法内部可以修改这个变量的值。
 
 
 */

+ (instancetype)shareSignalInstance {
    
    static id signalInstance = nil;
    //static MXWSignalInstance * signalInstance = nil;
    static dispatch_once_t  oneceTocken;
    dispatch_once(&oneceTocken, ^{
        if (signalInstance == nil) {
            signalInstance = [[self alloc] init];
        }
    });
    return  signalInstance;
}


@end
