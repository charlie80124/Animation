//
//  ViewController.m
//  Animation_Test
//
//  Created by charlie on 2016/10/5.
//  Copyright © 2016年 MBP4001. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "RotationViewController.h"
@interface ViewController (){

    UIImageView * imgView;
    UIPanGestureRecognizer * panG;
    UITapGestureRecognizer * tapG;
    UIView * cView1;
    UIView * cView2;
    UIView * cView3;
    UIView * cView4;
    BOOL goCenter;
    CGPoint  movedPoint ;
    UIButton * goBtn;
}
@end
#define RADIANS(X) (M_PI*(X)/180.0) // 轉成弧度
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ UIColor whiteColor];
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [imgView setImage:[UIImage imageNamed:@"main"]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.userInteractionEnabled = YES;
    imgView.backgroundColor = [ UIColor whiteColor];
    imgView.clipsToBounds = YES;
    imgView.layer.cornerRadius = 50;
    imgView.layer.borderColor = [ UIColor lightGrayColor].CGColor;
    imgView.layer.borderWidth =1;
    [imgView setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    panG = [[ UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [imgView addGestureRecognizer:panG];
    [imgView addGestureRecognizer:tapG];
    movedPoint = imgView.center;
    [self.view addSubview:imgView];
    
    cView1 = [ self newView];
    cView2 = [ self newView];
    cView2.backgroundColor = [ UIColor redColor];
    cView3 = [ self newView];
    cView3.backgroundColor = [ UIColor greenColor];
    cView4 = [self newView];
    cView4.backgroundColor = [UIColor yellowColor];
    [self setContentViewCenter];
    
    goBtn = [[ UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, self.view.frame.size.height-40, 40, 40)];
    [goBtn addTarget:self action:@selector(goNextController) forControlEvents:UIControlEventTouchUpInside];
    [goBtn setImage:[UIImage imageNamed:@"Rotation"] forState:UIControlStateNormal];
    [self.view addSubview:goBtn];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];

}
-(void)tap:(UITapGestureRecognizer*)tap{
    CGPoint center = self.view.center;
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    goCenter = !goCenter;
    if (goCenter) {
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [imgView setCenter:center];
            [self setContentViewCenter];
        } completion:^(BOOL finished) {
            CGPoint p1 = CGPointMake(imgView.center.x, imgView.center.y-100);
            CGPoint p2 = CGPointMake(imgView.center.x-100, imgView.center.y);
            CGPoint p3 = CGPointMake(imgView.center.x+100, imgView.center.y);
            CGPoint p4 = CGPointMake(imgView.center.x, imgView.center.y+100);
            [UIView animateWithDuration:1 animations:^{
                
                [cView1 setCenter:p1];
                [cView2 setCenter:p2];
                [cView3 setCenter:p3];
                [cView4 setCenter:p4];
                imgView.transform = CGAffineTransformMakeRotation(RADIANS(90));
            }];
        }];
        
        
//        [UIView animateWithDuration:1 animations:^{
//            [imgView setCenter:center];
//            [self setContentViewCenter];
//        } completion:^(BOOL finished) {
//            CGPoint p1 = CGPointMake(imgView.center.x, imgView.center.y-100);
//            CGPoint p2 = CGPointMake(imgView.center.x-100, imgView.center.y);
//            CGPoint p3 = CGPointMake(imgView.center.x+100, imgView.center.y);
//            [UIView animateWithDuration:1 animations:^{
//                
//                [cView1 setCenter:p1];
//                [cView2 setCenter:p2];
//                [cView3 setCenter:p3];
//
//                imgView.transform = CGAffineTransformMakeRotation(RADIANS(90));
//            }];
//        }];
        
    }else{
        [UIView animateWithDuration:1 animations:^{
            [self setContentViewCenter];
            imgView.transform = CGAffineTransformMakeRotation(RADIANS(0));
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                [imgView setCenter:movedPoint];
                [self setContentViewCenter];
            }];
        }];
    }
}
-(void)pan:(UIPanGestureRecognizer*)pan{
    imgView.transform = CGAffineTransformMakeRotation(RADIANS(0));
    CGPoint p = [panG locationInView:self.view];
    [imgView setCenter:p];
    goCenter = NO;
    movedPoint = imgView.center;
    [UIView animateWithDuration:0.2 animations:^{
        [cView1 setCenter:imgView.center];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.4 animations:^{
                [cView2 setCenter:imgView.center];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.6 animations:^{
                    [cView3 setCenter:imgView.center];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.8 animations:^{
                        [cView4 setCenter:imgView.center];
                    }];
                }];
            }];
        }
    }];
}
-(void)goNextController{


    RotationViewController * viewController = [[ RotationViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];

}




-(UIView*)newView{
    UIView * view1 = [[ UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [view1 setCenter:imgView.center];
    view1.backgroundColor = [ UIColor blueColor];
    view1.layer.cornerRadius = 25;
    [self.view addSubview:view1];
    return view1;
}
-(void)setContentViewCenter{
    [cView1 setCenter:imgView.center];
    [cView2 setCenter:imgView.center];
    [cView3 setCenter:imgView.center];
    [cView4 setCenter:imgView.center];

    [self.view bringSubviewToFront:imgView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
