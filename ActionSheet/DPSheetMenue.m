//
//  DPSheetMenue.m
//  ActionSheetDemo
//
//  Created by Ray on 16/1/7.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "DPSheetMenue.h"
#import "Masonry.h"
#import <QuartzCore/QuartzCore.h>

#define kMAX_SHEET_TABLE_HEIGHT   400

@interface DPSheetMenue () <UITableViewDataSource, UITableViewDelegate>
 @property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UIImageView *bottomView ;

@property (nonatomic, strong) void(^actionHandle)(NSInteger);
@end

@implementation DPSheetMenue

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor] ;
        
         _items = [NSArray array];
        
         _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15) ;
         [self addSubview:_tableView];
        _tableView.tableFooterView = self.bottomView ;
    
    }
    return self;
}

- (id)initWithItemTitles:(NSArray *)itemTitles
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
         _items = itemTitles;
    }
    return self;
}

-(UIImageView *)bottomView {

    if (_bottomView == nil) {
        _bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 15)];
        _bottomView.image = [UIImage imageNamed:@"trans_down.png"] ;
        _bottomView.contentMode = UIViewContentModeCenter ;
        _bottomView.backgroundColor = [UIColor blueColor] ;
    }
    return _bottomView ;
}


 
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float height = 0;
    float table_top_margin = 0;
    float table_bottom_margin = 5; //距离底部
    
    
    height += table_top_margin;
    
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    float contentHeight = self.tableView.contentSize.height;
    if (contentHeight > kMAX_SHEET_TABLE_HEIGHT) {
        contentHeight = kMAX_SHEET_TABLE_HEIGHT;
        self.tableView.scrollEnabled = YES;
    }else{
        self.tableView.scrollEnabled = NO;
    }
    self.tableView.frame = CGRectMake(0, height, self.bounds.size.width , contentHeight);
    height += self.tableView.bounds.size.height;
    
    height += table_bottom_margin;
    
    self.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, height)};
}

#pragma mark -

- (void)triggerSelectedAction:(void (^)(NSInteger))actionHandle
{
    self.actionHandle = actionHandle;
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.backgroundColor =
        cell.contentView.backgroundColor = [UIColor purpleColor] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14] ;
        label.textAlignment = NSTextAlignmentCenter ;
        label.textColor = BaseMenuTextColor ;
         label.backgroundColor = [UIColor clearColor] ;
        label.tag = 111 ;
        [cell.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(cell.contentView) ;
            make.centerY.equalTo(cell.contentView) ;
        }];
    }
    UILabel *lab = (UILabel*)[cell.contentView viewWithTag:111] ;
    lab.text = self.items[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.actionHandle) {
        double delayInSeconds = 0.15;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.actionHandle(indexPath.row);
        });
    }
}

@end