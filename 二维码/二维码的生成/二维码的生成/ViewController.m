//
//  ViewController.m
//  二维码的生成
//
//  Created by sh on 16/7/12.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:imageV];
    imageV.image = [QRCodeGenerator qrImageForString:@"www.baidu.com" imageSize:200];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
