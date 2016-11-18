//
//  TransitionViewController.m
//  Animation_Test
//
//  Created by charlie on 2016/10/7.
//  Copyright © 2016年 MBP4001. All rights reserved.
//

#import "TransitionViewController.h"
#import "KeyframeViewController.h"
@interface TransitionViewController (){

    UIImageView * imgView1 ;
    UIImageView * imgView2 ;
    UIImageView * imgView3 ;
    UIImageView * imgView4 ;
    UIView * contentView;
    UIView * testView;
    UIButton * btn;
    UIImageView * imgView5 ;
    UITapGestureRecognizer * tap ;

}

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"翻"];

    contentView = [[ UIView alloc]initWithFrame:self.view.frame];
    [contentView setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:contentView];
    
    imgView1 = [self newImageView];
    [imgView1 setFrame:CGRectMake((self.view.center.x-150)/2, (self.view.center.y-150)/2, 150, 150)];
    [imgView1 setImage:[UIImage imageNamed:@"p2"]];
    
    imgView2 = [self newImageView];
    [imgView2 setFrame:CGRectMake((self.view.center.x-150)/2+self.view.center.x, (self.view.center.y-150)/2, 150, 150)];
    [imgView2 setImage:[UIImage imageNamed:@"p3"]];

    imgView3 = [self newImageView];
    [imgView3 setFrame:CGRectMake(20, self.view.center.y, 150, 150)];
    [imgView3 setCenter:self.view.center];
    [imgView3 setImage:[UIImage imageNamed:@"p1"]];
    
    
//    imgView5 = [self newImageView];
    imgView5 = [[UIImageView alloc]init];
    imgView5.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    imgView5.contentMode = UIViewContentModeScaleAspectFit;
    [imgView5 setFrame:CGRectMake(0, self.view.center.y+100, 320, 200)];
    [imgView5 setImage:[UIImage imageNamed:@"p4"]];
    
    imgView4 = [self newImageView];
    [imgView4 setFrame:CGRectMake(20, self.view.center.y+150, 280, 150)];
    [imgView4 setImage:[UIImage imageNamed:@"p4"]];

    tap = [[ UITapGestureRecognizer alloc]initWithTarget:self action:@selector(test)];
    [imgView4 addGestureRecognizer:tap];
    
    
    btn = [[ UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40,self.view.frame.size.height-40 , 40, 40)];
    [btn setTitle:@"翻" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(transition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

    [self performSelector:@selector(transition) withObject:nil afterDelay:0.1];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
    UIImageView * imgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"next"]];
    [imgView setFrame:CGRectMake(0, 0, 33, 33)];
    UIButton *_backBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
    [_backBtn addTarget:self action:@selector(keyframe) forControlEvents:UIControlEventTouchUpInside];
    
    [imgView addSubview:_backBtn];
    UIBarButtonItem * btnItem = [[ UIBarButtonItem alloc]initWithCustomView:imgView];
    [self.navigationItem setRightBarButtonItem:btnItem];
}

-(void)transition{

    
    [UIView transitionWithView:imgView1 duration:1.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
    } completion:nil];
    
    [UIView transitionWithView:imgView2 duration:1.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    } completion:nil];
    
    [UIView transitionWithView:imgView3 duration:1.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
    } completion:nil];

    [UIView transitionWithView:imgView4 duration:1.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{

    } completion:nil];
    
   
}
-(void)test{


    [UIView animateWithDuration:2 animations:^{
        imgView4.frame =CGRectMake(0, self.view.center.y+100, 320, 200);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView transitionFromView:imgView4 toView:imgView5 duration:1 options:UIViewAnimationOptionTransitionCrossDissolve completion:nil];
        }
    }];



}

-(UIImageView *)newImageView{
    UIImageView * imgView = [[ UIImageView alloc]init];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.userInteractionEnabled = YES;
    [contentView addSubview:imgView];
    return imgView;
}


-(void)keyframe{
    [self.navigationController pushViewController:[[KeyframeViewController alloc]init] animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(BOOL)shouldAutorotate
{
    return NO;
}
@end
