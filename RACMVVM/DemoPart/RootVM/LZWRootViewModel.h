//
//  LZWRootViewModel.h
//  RACMVVM
//
//  Created by 刘志武 on 2017/9/5.
//  Copyright © 2017年 zhiwuLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZWModel.h"

@interface LZWRootViewModel : NSObject

@property (nonatomic, strong) RACSignal *signalViewModel;
@property (nonatomic, assign) BOOL isFresh;
@property (nonatomic, assign) NSInteger pageCount;

- (void)userSelectedRowPushNextVcName:(NSString *)goodsName imageView_url:(NSString *)image_url viewController:(UIViewController *)viewController;


@end
