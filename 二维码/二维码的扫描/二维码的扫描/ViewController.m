//
//  ViewController.m
//  二维码的扫描
//
//  Created by sh on 16/7/12.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "ViewController.h"
#import "ZBarReaderView.h"

@interface ViewController ()<ZBarReaderViewDelegate>
{
    //二维码的扫描框
    ZBarReaderView * _readerView;
    
    //修饰视图
    UIView * _scanView;
    
    //修饰视图上下滚动的线
    UIView * _line;
    
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createReaderView];
    [self createScanView];
    [self createLine];
    [self moveLine];
    
    
}

-(void)createReaderView{
    _readerView = [[ZBarReaderView alloc]init];
    _readerView.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:_readerView];
    //该属性设置是否打开闪光灯 0表示关闭 1表示打开
    _readerView.torchMode = 0;
    
    //设置是否自动聚焦
    _readerView.tracksSymbols = YES;
    
    //设置代理
    _readerView.readerDelegate = self;

    //开始扫描
    [_readerView start];
    
}

-(void)createScanView{
    
    _scanView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    
    _scanView.backgroundColor = [UIColor clearColor];
    
    _scanView.layer.borderWidth = 1;
    
    _scanView.layer.borderColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor;
    
    [self.view addSubview:_scanView];

}

-(void)createLine{
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 2)];
    _line.backgroundColor = [UIColor orangeColor];
    
    [_scanView addSubview:_line];
}

-(void)moveLine{
    
    static int i = 0;
    [UIView animateWithDuration:1 animations:^{
        if (i == 0) {
            _line.frame = CGRectMake(0, 200, 200, 2);
            i++;
        }else{
            _line.frame = CGRectMake(0, 0, 200, 2);
            i=0;
        }
    } completion:^(BOOL finished) {
        
        [self moveLine];
        
    }];
    
}


//当扫描结束时调用该协议方法
-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image{
    //获得扫描的符号
    const zbar_symbol_t * sym = zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
    
    //获得符号中对应的数组
    const char * ch = zbar_symbol_get_data(sym);
    
    NSLog(@"%s",ch);
    
    //停止扫描
    [_readerView stop];
    [_line removeFromSuperview];
    
    NSString * url = [NSString stringWithFormat:@"%s",ch];
    NSURL * webURL=[NSURL URLWithString:url];
    [[UIApplication sharedApplication]openURL:webURL];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
