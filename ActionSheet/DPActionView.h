//
//  DPActionView.h
//  ActionSheetDemo
//
//  Created by Ray on 16/1/7.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DPMenuActionHandler)(NSInteger index);

@interface DPActionView : UIView

/**
 *  获取单例
 */
+ (DPActionView *)sharedActionView;


/**
 *	选择列表弹出层
 *
 *	@param 	title           标题
 *	@param 	itemTitles      行标题
 *	@param 	itemSubTitles 	行子标题
 *	@param 	handler         回调，index从 0 开始
 */
+ (void)showSheetWithItemTitles:(NSArray *)itemTitles selectedHandle:(DPMenuActionHandler)handler;
/**
 *  是否显示
 */
@property (assign,nonatomic,readonly) BOOL isShowing ;
/**
 *  隐藏弹框
 */
-(void)dismiss ;

@end
