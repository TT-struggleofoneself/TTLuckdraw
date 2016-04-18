//
//  TTluckdrawView.h
//  TT_抽奖
//
//  Created by TT_code on 16/4/6.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTluckdrawView : UIView




@property(nonatomic,weak)UIViewController* VC;

/**
 *  获取xib
 *
 *  @return
 */
+ (instancetype)ttluckdraw;


/**
 *  开始抽奖
 */
-(void)StartLuckDraw;

@end
