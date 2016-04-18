//
//  ViewController.m
//  TT_抽奖
//
//  Created by TT_code on 16/4/6.
//  Copyright © 2016年 TT_code. All rights reserved.
//

/**
 *  读取XIB文件
 *
 */
#import "OBShapedButton.h"
#define  NSBundleloadNibNamed(nibname)  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil] firstObject];

#import "ViewController.h"
#import "TTluckdrawView.h"
@interface ViewController ()
@property(nonatomic,strong)TTluckdrawView * drawView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drawView=NSBundleloadNibNamed(@"TTluckdrawView");
    self.drawView.frame=CGRectMake(0, 0, 320, 320);
    self.drawView.center=self.view.center;
    self.drawView.VC=self;
    [self.view addSubview:self.drawView];
}




- (IBAction)start:(id)sender {    
    [self.drawView StartLuckDraw];
}




@end
