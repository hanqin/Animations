//
//  BezierPathAnimViewController.m
//  Animations
//
//  Created by twer on 13/09/2015.
//  Copyright © 2015 hqin. All rights reserved.
//

#import "BezierPathAnimViewController.h"

@interface BezierPathAnimViewController ()

@property(nonatomic, strong) IBOutlet UIView *container;

@end

@implementation BezierPathAnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGPoint startingPoint = CGPointMake(0, 150);
    
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath moveToPoint:startingPoint];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    
    [self.container.layer addSublayer:pathLayer];
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = startingPoint;
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"rocket"].CGImage;
    [self.container.layer addSublayer:shipLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.repeatCount = 50;
    [shipLayer addAnimation:animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
