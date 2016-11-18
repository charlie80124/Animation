//
//  KeyframeViewController.m
//  Animation_Test
//
//  Created by charlie on 2016/10/13.
//  Copyright © 2016年 MBP4001. All rights reserved.
//

#import "KeyframeViewController.h"

@interface KeyframeViewController (){

    UIImageView * airplane ;
    UIButton * btn;
    BOOL isBig;
}

@end

@implementation KeyframeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AirPlane";
    self.view.backgroundColor = [ UIColor lightGrayColor];
    isBig = YES;
    
    airplane = [[ UIImageView alloc]init];
    [airplane setImage:[UIImage imageNamed:@"airplane"]];
//    airplane.transform = CGAffineTransformMakeScale(-1.0, 1.0); // 將照片鏡像處理
    [self.view addSubview:airplane];
    [airplane setFrame:CGRectMake(0, self.view.center.y, 80, 80)];
    [self performSelector:@selector(fly) withObject:nil afterDelay:0.0];
    
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    [btn setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-80)];
    [btn setTitle:@"飛飛機" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(flyAirplane) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 40;
    [self.view addSubview:btn];
    
}
-(void)fly{

    //addKeyframeWithRelativeStartTime中的startTime和relativeDuration都是相對整個動畫的持續時間（2秒）的百分比，設置成0.5就代表2*0.5＝1（秒）。
    
    [UIView animateKeyframesWithDuration:2.0 delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            [airplane setCenter:CGPointMake(airplane.center.x+50, airplane.center.y)];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            [airplane setCenter:CGPointMake(airplane.center.x+100, airplane.center.y-50)];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.50 relativeDuration:0.50 animations:^{
            [airplane setCenter:CGPointMake(airplane.center.x+140, airplane.center.y-200)];
            airplane.alpha =0.1;
        }];
    } completion:nil];
    
}

-(void)flyAirplane{
    
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        
        CGRect size = btn.frame;
        
        if (size.size.width > self.view.frame.size.width*3/4) {
            isBig = NO;
        }else if (size.size.width <= 80){
            isBig = YES;
        }
        
        if (isBig) {
            size.size.width +=25;
        }else{
            size.size.width -=25;

        }
        
        
        [btn setFrame:size];
        [btn setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-80)];
    } completion:nil];
    
    
    
    
    
    [airplane setFrame:CGRectMake(0, self.view.center.y, 80, 80)];
    airplane.alpha =1.0;
    [self fly];
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
