//
//  CADisplayLinkViewController.m
//  Animations
//
//  Created by twer on 23/09/2015.
//  Copyright © 2015 hqin. All rights reserved.
//

#import "CADisplayLinkViewController.h"

@interface CADisplayLinkViewController ()

@property(nonatomic, strong) IBOutlet UIView *containerView;
@property(nonatomic, strong) IBOutlet UIImageView *ballView;
@property(nonatomic, assign) CGFloat duration;
@property(nonatomic, assign) CGFloat timeOffset;
@property(nonatomic, assign) CGPoint fromValue;
@property(nonatomic, assign) CGPoint toValue;
@property(nonatomic, strong) CADisplayLink *timer;
@property(nonatomic, assign) CFTimeInterval lastStep;

@end

@implementation CADisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self animate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animate];
}

- (void)animate {
    self.ballView.center = CGPointMake(150, 32);
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = CGPointMake(150, 32);
    self.toValue = CGPointMake(150, 268);
    [self.timer invalidate];
    self.lastStep = CACurrentMediaTime();
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
}

- (void)step: (CADisplayLink *)timer {
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);
    
    float time = self.timeOffset / self.duration;
    time = [self bounceEaseOut:time];
    CGPoint position = [self interpolateFromValue:self.fromValue toValue:self.toValue time:time];
    self.ballView.center = position;
    
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
    }
}

float interpolate(float from, float to, float time) {
    return (to - from) * time + from;
}

- (CGPoint)interpolateFromValue: (CGPoint)fromValue toValue:(CGPoint)toValue time: (float)time {
    return CGPointMake(interpolate(fromValue.x, toValue.x, time), interpolate(fromValue.y, toValue.y, time));
}

- (float)bounceEaseOut: (float)t {
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
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
