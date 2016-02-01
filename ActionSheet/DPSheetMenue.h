//
//  DPSheetMenue.h
//  ActionSheetDemo
//
//  Created by Ray on 16/1/7.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BaseMenuBackgroundColor  [UIColor colorWithWhite:1.0 alpha:1.0]
#define BaseMenuTextColor        [UIColor darkTextColor]
 
#define kBottomButtonHeigh   44 //距离底部的间距

@interface DPSheetMenue : UIView

- (id)initWithItemTitles:(NSArray *)itemTitles;


 
- (void)triggerSelectedAction:(void(^)(NSInteger))actionHandle;

@end
