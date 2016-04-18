//
//  TTluckdrawView.m
//  TT_抽奖
//
//  Created by TT_code on 16/4/6.
//  Copyright © 2016年 TT_code. All rights reserved.
//
#import "OBShapedButton.h"
#import "TTluckdrawView.h"
#import "UIAlertController+TTExtend.h"
@interface TTluckdrawView()
@property (nonatomic, strong) CADisplayLink *link;
@property (weak, nonatomic) IBOutlet UIView *startBtn;
@property(nonatomic)CGFloat angle;//旋转角度
@property(nonatomic)BOOL isadd;//是否是加
@property(nonatomic)CGFloat totalangle;
@property(nonatomic)NSInteger  number;//随机数





@property (strong, nonatomic) IBOutletCollection(OBShapedButton) NSArray *views;

@end


@implementation TTluckdrawView

/**
 *  获取xib
 *
 *  @return
 */
+ (instancetype)ttluckdraw
{
    return  [[NSBundle mainBundle] loadNibNamed:@"TTluckdrawView" owner:nil options:nil][0];
}

/**
 *  懒加载---时间
 *
 *  @return
 */
- (CADisplayLink *)link
{
    if (_link == nil) {
        self.angle=1;
        self.isadd=YES;
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(angleChange)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _link;
}


#pragma mark - 开始旋转
- (void)angleChange
{
    if(self.isadd){
        self.angle++;
        if(self.angle>self.number){
            self.isadd=NO;
        }
    }else{
        self.angle--;
        if(self.angle<=0){
            [self pausedLuckDraw];
        }
    }
//     CGFloat angle =M_PI_2;
    CGFloat angle =self.angle*0.2*0.5/360*M_PI;
  //  NSLog(@"我靠  我打印下:%f",angle/M_PI*360);
    self.totalangle+=angle/M_PI*180;
    self.startBtn.transform = CGAffineTransformRotate(self.startBtn.transform, angle);
}




/**
 *  开始抽奖
 */
-(void)StartLuckDraw
{
    self.link=nil;
    self.number = (arc4random() % 400) + 200;
     self.link.paused = NO;
}


/**
 *  递归计算角度
 *
 *  @param newangle 传入总的角度
 *
 *  @return
 */
-(CGFloat)backangle:(CGFloat)newangle
{
    CGFloat angle=newangle;
    if(angle>360.0){
        angle=angle-360.0;
      return  [self backangle:angle];
    }
    return angle;
}


/**
 *  暂停抽奖
 */
-(void)pausedLuckDraw
{
    self.link.paused = YES;
    NSLog(@"我是总的角度:%f",self.totalangle/M_PI*360);
    
    //旋转角度为
    CGFloat angle=[self backangle:self.totalangle];
    NSLog(@"我是旋转之后的角度:%f",angle);
    
    //转盘上的图片是美工按照一定比例设计的 角度是已知的。当然这里只是一个简单的domo.
    NSInteger  index=0;
    if(angle>0 && angle<=30){
        index=2;
    }else if(angle>30 && angle<=110){
        index=5;
    }else if(angle>110 && angle<=175){
        index=4;
    }else if(angle>175 && angle<=235){
        index=3;
    }else if(angle>235 && angle<=255){
        index=1;
    }else if(angle>255 && angle<=360){
        index=6;
    }
    
    [UIAlertController showAlertMessage:[NSString stringWithFormat:@"恭喜您中了%ld等奖",index] title:@"中奖提醒" VC:self.VC Sure:^(NSInteger index) {
        NSLog(@"我知道了");
    } Cancel:^(NSInteger index) {
        NSLog(@"取消");
    }];
    
    
  
    NSLog(@"恭喜您中了:%ld等奖",index);
}



@end
