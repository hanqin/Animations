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
@property(nonatomic, strong) CALayer *shipLayer;
@property(nonatomic, strong) CAShapeLayer *pathLayer;

@end

@implementation BezierPathAnimViewController

static NSString* kAnimationKey = @"kAnimationKey";

- (void)viewDidLoad {
    [super viewDidLoad];
    CGPoint startingPoint = CGPointMake(150, 150);
    
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath moveToPoint:startingPoint];
    [bezierPath addCurveToPoint:CGPointMake(450, 450) controlPoint1:CGPointMake(75, 250) controlPoint2:CGPointMake(225, 350)];
    
    self.pathLayer = [CAShapeLayer layer];
    self.pathLayer.path = bezierPath.CGPath;
    self.pathLayer.fillColor = [UIColor clearColor].CGColor;
    self.pathLayer.strokeColor = [UIColor redColor].CGColor;
    self.pathLayer.lineWidth = 3.0f;
    
    [self.container.layer addSublayer:self.pathLayer];
    
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 64, 64);
    self.shipLayer.position = startingPoint;
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"space_ship"].CGImage;
    [self.container.layer addSublayer:self.shipLayer];
}

- (IBAction)startAnimation:(id)sender {
    CAKeyframeAnimation *flyAnimation = [CAKeyframeAnimation animation];
    flyAnimation.keyPath = @"position";
    flyAnimation.duration = 4.0;
    flyAnimation.path = self.pathLayer.path;
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
    
    [self.shipLayer addAnimation:animationGroup forKey:kAnimationKey];
}

- (IBAction)stopAnimation:(id)sender {
    [self.shipLayer removeAnimationForKey:kAnimationKey];
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
