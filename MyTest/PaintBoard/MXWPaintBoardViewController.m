//
//  MXWPaintBoardViewController.m
//  MyTest
//
//  Created by 明先伟 on 2022/8/4.
//

#import "MXWPaintBoardViewController.h"
#import "MXWPaintBoardView.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface MXWPaintBoardViewController () <GCDAsyncSocketDelegate>

@property (weak, nonatomic) IBOutlet MXWPaintBoardView *myPaintBoardView;

/*!
 @property 客户端socket
 @abstract 客户端socket
 */
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;


@end

@implementation MXWPaintBoardViewController

#pragma mark - 懒加载

/*!
 @method 懒加载
 @abstract 初始化客户端socket对象
 @result 客户端socket对象
 */
- (GCDAsyncSocket *)clientSocket {
    if (!_clientSocket) {
        _clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self
                                                delegateQueue:dispatch_get_main_queue()];
    }
    return _clientSocket;
}


#pragma mark - === LifeClicle ===

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myPaintBoardView.lineColor = [UIColor blackColor];
    self.myPaintBoardView.lineWith = 10;
    [self grenBtnClick:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.clientSocket disconnect];
}


#pragma mark - === IBAction ===

- (IBAction)conncectSocket:(UIBarButtonItem *)sender {
    // 2.连接服务器
    NSError *error = nil;
    
    if(sender.tag == 1){
        [self.clientSocket connectToHost:@"127.0.0.1"
                                  onPort:8888
                                   error:&error];
        if (error) {
            NSLog(@"error%@", error);
            sender.tag = 1;
            sender.title = @"链接到8888";
        } else {
            sender.tag = 2;
            sender.title = @"断开连接";
            NSLog(@"链接成功");
        }
    } else {
        [self.clientSocket disconnectAfterReadingAndWriting];
        sender.tag = 1;
        sender.title = @"链接到8888";
    }
}


/** 发送数据 */
- (IBAction)shareMyPaint:(id)sender {
    
    NSArray *dataArray = [self.myPaintBoardView arrayWithMXWBezierPathArray];
    if(dataArray.count <=0 ){
        return;
    }
    
    NSData *sendData = [NSJSONSerialization
                        dataWithJSONObject:dataArray
                        options:NSJSONWritingPrettyPrinted
                        error:nil];
    
    
    [self.clientSocket writeData:sendData
                     withTimeout:-1
                             tag:5555];
    
}





- (IBAction)sliderValueChanged:(UISlider *)sender{
    self.myPaintBoardView.lineWith = sender.value;
}

- (IBAction)grenBtnClick:(id)sender {
    self.myPaintBoardView.lineColor = [UIColor colorWithRed:115/255.0 green:250/255.0 blue:111/225.0 alpha:1];
}


- (IBAction)blueBtnClick:(id)sender {
    self.myPaintBoardView.lineColor = [UIColor colorWithRed:93/255.0 green:122/255.0 blue:248/225.0 alpha:1];
}


- (IBAction)orangeBtnClick:(id)sender {
    self.myPaintBoardView.lineColor = [UIColor colorWithRed:232/255.0 green:130/255.0 blue:108/225.0 alpha:1];
}



- (IBAction)clearBtnClick:(id)sender {
    [self.myPaintBoardView clear];
}


- (IBAction)rebackBtnClick:(id)sender {
    [self.myPaintBoardView reback];
}


- (IBAction)eraserBtnClick:(id)sender {
    [self.myPaintBoardView eraser];
}



- (IBAction)saveBtnClick:(id)sender {
    [self.myPaintBoardView saveToImage];
}

#pragma mark - === GCDAsyncSocketDelegate ===

/** 连接到主机  需要 读数据 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"ConnectToHost");
    [self.clientSocket readDataWithTimeout:-1
                                       tag:11111];
}

/*!
 @method  socket与服务器断开连接
 @abstract 断开服务器连接回调方法
 @param sock 客服端socket
 @param err 错误
 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    self.navigationItem.rightBarButtonItem.tag = 1;
    self.navigationItem.rightBarButtonItem.title = @"链接8888";
    NSLog(@"Disconnect");
    NSLog(@"socketDidDisconnecterr%@", err);
}


/** 从服务器读取数据 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {

    NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:data
                                                            options:kNilOptions
                                                              error:nil];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:tempArray.count];
    [tempArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MXWBezierPath * path = [MXWBezierPath bezierPathFromDic:obj];
        if(path != nil){
            [array addObject:path];
        }
    }];
    [self.myPaintBoardView setPathwithArry:array];
    
    
    /** 这里千万不要忘记。 拿到数据之后 要继续 拿数据 这样才会持续的激活 代理 */
    [self.clientSocket readDataWithTimeout:-1
                          tag:1111];
}



@end
