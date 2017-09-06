//
//  LZWRootViewModel.m
//  RACMVVM
//
//  Created by 刘志武 on 2017/9/5.
//  Copyright © 2017年 zhiwuLiu. All rights reserved.
//

#import "LZWRootViewModel.h"
#import "LZWNextViewController.h"
@interface LZWRootViewModel ()

@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation LZWRootViewModel

#pragma mark -- 请求数据
-(RACSignal *)signalViewModel
{
    if (!_signalViewModel) {
        self.arrayData = [NSMutableArray array];
        
        @weakify(self);
        
        self.signalViewModel = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            @strongify(self);
            
            NSString *baseUrl = @"url";
            NSMutableDictionary *dictData = [NSMutableDictionary dictionary];
            [dictData setObject:[NSString stringWithFormat:@"%ld", _pageCount] forKey:@"pageCount"];
            [LZFNetWoking getWithUrl:baseUrl params:dictData success:^(id response) {
                
                if (self.isFresh) {
                    [_arrayData removeAllObjects];
                }
                NSMutableDictionary *dictResult = response;
                NSMutableArray *array = [[[dictResult objectForKey:@"goodsRecommendTypeFormBeans"] firstObject] objectForKey:@"goodsRecommendFormList"];
                for (NSMutableDictionary *dict in array) {
                    LZWModel *model = [[LZWModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [_arrayData addObject:model];
                }
                [subscriber sendNext:_arrayData];
                [subscriber sendCompleted];
                
            } fail:^(NSError *error) {
                [subscriber sendError:error];
            } showHUD:NO];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"取消订阅!!!");
            }];
        }];
    }
    return _signalViewModel;
}

#pragma mark -- 跳转
-(void)userSelectedRowPushNextVcName:(NSString *)goodsName imageView_url:(NSString *)image_url viewController:(UIViewController *)viewController
{
    LZWNextViewController *nextVc = [[LZWNextViewController alloc]init];
    nextVc.signalNext = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSMutableDictionary *dictNext = [NSMutableDictionary dictionary];
        [dictNext setObject:goodsName forKey:@"goodName"];
        [dictNext setObject:image_url forKey:@"goodUrl"];
        [subscriber sendNext:dictNext];
        [subscriber sendCompleted];
       return [RACDisposable disposableWithBlock:^{
           NSLog(@"取消订阅");
       }];
    }];
    //反向传值:
    nextVc.subJect = [RACSubject subject];
    [nextVc.subJect subscribeNext:^(id x) {
        
        NSLog(@"反向传值 = %@", x);
        viewController.navigationItem.title = x;
    }];
    
    [viewController.navigationController pushViewController:nextVc animated:YES];
}

@end
