//
//  main.m
//  Server
//
//  Created by 明先伟 on 2022/9/14.
//

#import <Foundation/Foundation.h>
#import "Server.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Server *server = [[Server alloc]init];
        [server startServer];
        // 开启主运行循环
        [[NSRunLoop mainRunLoop] run];
        
        
    }
    return 0;
}
