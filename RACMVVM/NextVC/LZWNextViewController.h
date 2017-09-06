//
//  LZWNextViewController.h
//  RACMVVM
//
//  Created by 刘志武 on 2017/9/6.
//  Copyright © 2017年 zhiwuLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZWNextViewController : UIViewController

@property (nonatomic, strong) RACSignal *signalNext;

@property (nonatomic, strong) RACSubject *subJect;

@end
