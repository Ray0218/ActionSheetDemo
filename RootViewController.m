//
//  RootViewController.m
//  ActionSheetDemo
//
//  Created by Ray on 16/1/7.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "DPActionView.h"
#import "Masonry.h"
#import "RootViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>

    {
    UITableView *_tableView;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];

    self.title = @"actionSheet";

    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"已关注" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pvt_btn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
}


#pragma mark -弹出选框
- (void)pvt_btn {
    [DPActionView showSheetWithItemTitles:@[ @"Wedding Bell", @"I'm Yours", @"When I was your mam" ]
                           selectedHandle:^(NSInteger index) {
                               NSLog(@"点击了第%zd行", index);
                               
                               UIAlertView *alter =[[ UIAlertView alloc]initWithTitle:@"dddd" message:@"点击" delegate:nil cancelButtonTitle:@"Cancle" otherButtonTitles: nil];
                               [alter show];
                               
                               
                           }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndetucy = @"cellIndetucy";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetucy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetucy];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.textLabel.text = [NSString stringWithFormat:@"第  %zd   行", indexPath.row];

    return cell;
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
