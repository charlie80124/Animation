//
//  RotationViewController.m
//  Animation_Test
//
//  Created by charlie on 2016/10/6.
//  Copyright © 2016年 MBP4001. All rights reserved.
//

#import "RotationViewController.h"
#import "TransitionViewController.h"
@interface RotationViewController (){

    UIImageView * centerView;
    
    UIPanGestureRecognizer * panG;
    
    NSMutableArray * points;
    
    float angle;
}

@end
#define Center self.view.center
#define RADIANS(X) (M_PI*(X)/180.0) // 轉成弧度
@implementation RotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self setTitle:@"轉"];

    centerView = [[ UIImageView alloc]initWithImage:[UIImage imageNamed:@"p3"]];
    [centerView setFrame:CGRectMake(0, 0, 300, 300)];
    [centerView setCenter:Center];
    centerView.backgroundColor = [ UIColor colorWithRed:197.0/255 green:202.0/255 blue:207.0/255 alpha:1];
    centerView.contentMode = UIViewContentModeScaleAspectFit;
    centerView.clipsToBounds = YES;
    centerView.layer.cornerRadius = 150;
    centerView.layer.borderWidth = 1;
    centerView.layer.borderColor = [ UIColor redColor].CGColor;
    centerView.userInteractionEnabled = YES;
    
    [self.view addSubview:centerView];
    
    panG = [[ UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    panG.maximumNumberOfTouches=1;
    [centerView addGestureRecognizer:panG];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
    UIImageView * imgView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"next"]];
    [imgView setFrame:CGRectMake(0, 0, 33, 33)];
    UIButton *_backBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
    [_backBtn addTarget:self action:@selector(transition) forControlEvents:UIControlEventTouchUpInside];
    
    [imgView addSubview:_backBtn];
    UIBarButtonItem * btnItem = [[ UIBarButtonItem alloc]initWithCustomView:imgView];
    [self.navigationItem setRightBarButtonItem:btnItem];
}

-(void)rotation:(UIPanGestureRecognizer*)pan{

    if (pan.state == UIGestureRecognizerStateBegan) {
        
        points = [[ NSMutableArray alloc]init];
        [points addObject:[NSValue valueWithCGPoint:[pan locationInView:centerView]]];
    }else{
        [points addObject:[NSValue valueWithCGPoint:[pan locationInView:centerView]]];
    
        if (points.count < 2) {
            return;
        }
        
        CGPoint start = [(NSValue*)[points firstObject] CGPointValue];
        CGPoint end = [(NSValue*)[points lastObject]CGPointValue];
        
        CGFloat centerX = Center.x;
        CGFloat centerY = Center.y;
        
        CGFloat startX = start.x;
        CGFloat startY = start.y;
        
        CGFloat endX = end.x;
        CGFloat endY = end.y;
        
//        float a =sqrtf(pow(startX - centerX,2) +pow(startY-centerY, 2));
//        float b =sqrtf(pow(endX - centerX,2) +pow(endY-centerY, 2));
//        float c =sqrtf(pow(endX - startX,2) +pow(endY-startY, 2));
//        
        CGFloat goAngle = 0 ;
//        goAngle =  acosf((pow(a, 2) + pow(b, 2) - pow(c, 2))/(2*a*b)) * 180 / M_PI; // 角度
//        NSLog(@"%f",goAngle);
//       用餘弦定理去判斷角度 會無法得知正負號 只能順時針
        
        float a = startX - centerX;
        float b = startY - centerY;
        float c = endX - centerX;
        float d = endY - centerY;
        CGFloat atanA = atan2(a, b);
        CGFloat atanB = atan2(c, d);
        goAngle = (atanA - atanB)*180/M_PI;
        NSLog(@"%f",goAngle);
        
        if (goAngle > 180) {
            goAngle -=360;
        }else if (goAngle < -180){
            goAngle -=360;
        }
        angle = angle+goAngle;
        
        centerView.transform = CGAffineTransformMakeRotation(RADIANS(angle)); //弧度
    }
}
-(void)transition{
    
    [self.navigationController pushViewController:[[TransitionViewController alloc]init] animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
