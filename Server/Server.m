//
//  Server.m
//  Server
//
//  Created by 明先伟 on 2022/9/14.
//

#import "Server.h"
#import "GCDAsyncSocket.h"

@interface Server () <GCDAsyncSocketDelegate>
/*!
 @property 服务器socket对象
 @abstract 服务器socket对象
 */
@property (nonatomic, strong) GCDAsyncSocket *serverSocket;
/*!
 @property 客户端socket对象数组
 @abstract 客户端socket对象数组
 */
@property (nonatomic, strong) NSMutableArray *clientSocketArray;
@end

@implementation Server


- (NSMutableArray *)clientSocketArray {
    if (!_clientSocketArray) {
        _clientSocketArray = [NSMutableArray array];
    }
    return _clientSocketArray;
}
/*!
 @method  开启服务
 @abstract 开启服务器TCP连接服务
 */
- (void)startServer {
    
    self.serverSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    [self.serverSocket acceptOnPort:8888 error:&error];
    if (error) {
        NSLog(@"服务开启失败");
    } else {
        NSLog(@"服务开启成功");
    }
    
}

#pragma mark - GCDAsyncSocketDelegate
/*!
 @method  收到socket端连接回调
 @abstract 服务器收到socket端连接回调
 */
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    [self.clientSocketArray addObject:newSocket];
    [newSocket readDataWithTimeout:-1 tag:self.clientSocketArray.count];
}
/*!
 @method  收到socket端数据的回调
 @abstract 服务器收到socket端数据的回调
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    // 直接进行转发数据
    for (GCDAsyncSocket *clientSocket in self.clientSocketArray) {
        if (sock != clientSocket) {
            [clientSocket writeData:data withTimeout:-1 tag:0];
        }
    }
    [sock readDataWithTimeout:-1 tag:0];
    
}


@end
