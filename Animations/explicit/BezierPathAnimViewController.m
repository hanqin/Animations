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
    CGPoint startingPoint = CGPointMake(150, 150);
    
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath moveToPoint:startingPoint];
    [bezierPath addCurveToPoint:CGPointMake(450, 450) controlPoint1:CGPointMake(75, 250) controlPoint2:CGPointMake(225, 350)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    
    [self.container.layer addSublayer:pathLayer];
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = startingPoint;
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"space_ship"].CGImage;
    [self.container.layer addSublayer:shipLayer];
    
    CAKeyframeAnimation *flyAnimation = [CAKeyframeAnimation animation];
    flyAnimation.keyPath = @"position";
    flyAnimation.duration = 4.0;
    flyAnimation.path = bezierPath.CGPath;
    flyAnimation.rotationMode = kCAAnimationRotateAuto;
    flyAnimation.repeatCount = 50;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation";
    rotationAnimation.duration = 2.0;
    rotationAnimation.byValue = @(M_PI * 2);
    rotationAnimation.repeatCount = 50;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[flyAnimation, rotationAnimation];
    animationGroup.duration = 4.0;
    animationGroup.repeatCount = 50;
    
    [shipLayer addAnimation:animationGroup forKey:nil];
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
