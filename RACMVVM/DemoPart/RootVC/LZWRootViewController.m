//
//  LZWRootViewController.m
//  RACMVVM
//
//  Created by 刘志武 on 2017/9/5.
//  Copyright © 2017年 zhiwuLiu. All rights reserved.
//

#import "LZWRootViewController.h"
#import "LZWRootTableViewCell.h"

@interface LZWRootViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableViewRoot;
@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation LZWRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RACMVVM";
    //创建表格
    [self creatRootTableView];
}
#pragma mark -- 创建表格
- (void)creatRootTableView
{
    self.tableViewRoot = ({
        UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        tableV.backgroundColor = [UIColor whiteColor];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableV];
        tableV;
    });
    //注册cell
    [self.tableViewRoot registerClass:[LZWRootTableViewCell class] forCellReuseIdentifier:@"cellRoot"];
    
    //请求数据
    [self getRootData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZWRootTableViewCell *cellR = [tableView dequeueReusableCellWithIdentifier:@"cellRoot"];
    cellR.model = _arrayData[indexPath.row];
    return cellR;
}
#pragma mark -- 跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LZWModel *model = _arrayData[indexPath.row];
    [_rootViewModel userSelectedRowPushNextVcName:model.goods_main_title imageView_url:model.goods_logo viewController:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark -- 请求数据
- (void)getRootData
{
    [self sendRequest:1 iSRefresh:YES];

    //下拉刷新
    self.tableViewRoot.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendRequest:1 iSRefresh:YES];
        [self.tableViewRoot.mj_header endRefreshing];
    }];
 
    self.tableViewRoot.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self sendRequest:2 iSRefresh:NO];
        [self.tableViewRoot.mj_footer endRefreshing];
    }];
}

- (void)sendRequest:(NSInteger)pageCount iSRefresh:(BOOL)isResfresh
{
    @weakify(self);
    self.rootViewModel.pageCount = pageCount;
    self.rootViewModel.isFresh = isResfresh;
    [_rootViewModel.signalViewModel subscribeNext:^(NSArray *array) {
        @strongify(self);
        self.arrayData = [array copy];
        [self.tableViewRoot reloadData];
    }];
}
-(LZWRootViewModel *)rootViewModel
{
    if (!_rootViewModel) {
        _rootViewModel = [[LZWRootViewModel alloc]init];
    }
    return _rootViewModel;
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
