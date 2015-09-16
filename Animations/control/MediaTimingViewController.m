//
//  MediaTimingViewController.m
//  Animations
//
//  Created by twer on 16/09/2015.
//  Copyright © 2015 hqin. All rights reserved.
//

#import "MediaTimingViewController.h"

@interface MediaTimingViewController ()

@property(nonatomic, strong) IBOutlet UIView *containerView;
@property(nonatomic, strong) IBOutlet UILabel *speedLabel;
@property(nonatomic, strong) IBOutlet UILabel *timeOffsetLabel;
@property(nonatomic, strong) IBOutlet UISlider *speedSlider;
@property(nonatomic, strong) IBOutlet UISlider *timeOffsetSlider;

@property(nonatomic, assign) CGPathRef path;
@property(nonatomic, strong) CALayer *shipLayer;

@end

@implementation MediaTimingViewController

- (IBAction)play: (id)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.timeOffset = self.timeOffsetSlider.value;
    animation.speed = self.speedSlider.value;
    animation.duration = 10.0;
    animation.path = self.path;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeRemoved;
    [self.shipLayer addAnimation:animation forKey:@"slide"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGAffineTransform transform = CGAffineTransformMakeScale(0.9, 0.9);
    self.path = CGPathCreateWithEllipseInRect(self.containerView.bounds, &transform);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = self.path;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    self.shipLayer = [CALayer layer];
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"space_ship"].CGImage;
    self.shipLayer.frame = CGRectMake(0, 0, 64, 64);
    self.shipLayer.position = CGPathGetPathBoundingBox(self.path).origin;
    [self.containerView.layer addSublayer:self.shipLayer];
    
    [self updateSliders:nil];
}

- (IBAction)updateSliders: (id)sender {
    CFTimeInterval timeOffset = self.timeOffsetSlider.value;
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"%0.2f", timeOffset];
    float speed = self.speedSlider.value;
    self.speedLabel.text = [NSString stringWithFormat:@"%0.2f", speed];
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
