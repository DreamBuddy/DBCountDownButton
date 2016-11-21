//
//  ViewController.m
//  DBCountDownButtonDemo
//
//  Created by Xu Mengtong on 21/11/16.
//  Copyright © 2016年 Xu Mengtong. All rights reserved.
//

#import "ViewController.h"
#import "DBCountDownButton.h"

#import <ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DBCountDownButton *button = [DBCountDownButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 200, 50);
    
    [button setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    
    [button countDownChanging:^NSString *(DBCountDownButton *countDownButton, NSUInteger second) {
        return [NSString stringWithFormat:@"剩余%lu秒可以重新获取",(unsigned long)second];
    }];
    
    [button countDownFinished:^NSString *(DBCountDownButton *countDownButton, NSUInteger second) {
        return @"点击重新获取";
    }];
    
    @weakify(button);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(button)
        
        [button startCountDownWithSecond:10];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
