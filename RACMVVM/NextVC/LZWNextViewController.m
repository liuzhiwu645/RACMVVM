//
//  LZWNextViewController.m
//  RACMVVM
//
//  Created by 刘志武 on 2017/9/6.
//  Copyright © 2017年 zhiwuLiu. All rights reserved.
//

#import "LZWNextViewController.h"

@interface LZWNextViewController ()

@property (nonatomic, strong) NSMutableDictionary *dictData;

@end

@implementation LZWNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"第二个VC";
    self.dictData = [NSMutableDictionary dictionary];
    
    @weakify(self);
    [_signalNext subscribeNext:^(NSMutableDictionary *dictData) {
        @strongify(self);
        self.dictData = dictData;
    }];
    
    //UI
    [self creatView];
}
#pragma mark -- UI显示
- (void)creatView
{
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@150);
        make.width.height.equalTo(@100);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageV.mas_bottom).offset(50);
        make.height.equalTo(@20);
        make.width.equalTo(@200);
    }];
    
    NSString *ima_url = [_dictData objectForKey:@"goodUrl"];
    NSString *goodName = [_dictData objectForKey:@"goodName"];
    [imageV sd_setImageWithURL:[NSURL URLWithString:ima_url]];
    label.text = goodName;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"我是按钮" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)buttonAction:(UIButton *)button
{
    [_subJect sendNext:@"武哥最帅啦!!!"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
