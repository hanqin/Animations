//
//  TransitionAnimViewController.m
//  Animations
//
//  Created by twer on 13/09/2015.
//  Copyright © 2015 hqin. All rights reserved.
//

#import "TransitionAnimViewController.h"

@interface TransitionAnimViewController ()

@property(nonatomic, strong) IBOutlet UIImageView *imageView;
@property(nonatomic, copy) NSArray *images;
@property(nonatomic, copy) NSArray *transitionTypes;
@property(nonatomic, copy) NSArray *transitionSubTypes;

@end

@implementation TransitionAnimViewController

- (IBAction)changeImage:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.type = self.transitionTypes[arc4random() % self.transitionTypes.count];
    transition.subtype = self.transitionSubTypes[arc4random() % self.transitionSubTypes.count];
    
    [self.imageView.layer addAnimation:transition forKey:nil];
    [self showNextImage];
}

- (IBAction)changeImageWithCustomTransition:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, YES, 0.0);
    [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIImageView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.imageView.bounds;
    
    [self.imageView addSubview:coverView];
    [self showNextImage];
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished){
        [coverView removeFromSuperview];
    }];
}

- (void)showNextImage {
    UIImage *currentImage = self.imageView.image;
    NSInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % self.images.count;
    self.imageView.image = [self.images objectAtIndex:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = @[
                    [UIImage imageNamed:@"model_1"],
                    [UIImage imageNamed:@"model_2"],
                    [UIImage imageNamed:@"model_3"],
                    [UIImage imageNamed:@"model_4"]
                    ];
    self.transitionTypes = @[kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal];
    self.transitionSubTypes = @[kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom];
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
