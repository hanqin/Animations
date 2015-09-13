//
//  ViewController.m
//  Animations
//
//  Created by hqin on 15/9/8.
//  Copyright (c) 2015年 hqin. All rights reserved.
//

#import "ViewController.h"
#import "TiledImageViewController.h"
#import "AVFoundation/AVFoundation.h"

@interface ViewController ()

@property(nonatomic, strong) IBOutlet UIView *layerView;
@property(nonatomic, strong) CALayer* blueLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAVPlayerLayer];
}

- (void)addAVPlayerLayer {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"effect" withExtension:@"mp4"];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.layerView.layer.bounds;
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    playerLayer.transform = transform;
    
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 20.0;
    playerLayer.borderColor = [UIColor redColor].CGColor;
    playerLayer.borderWidth = 5.0;
    
    [self.layerView.layer addSublayer:playerLayer];
    
    [player play];
}

- (void)addEmitterLayer {
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.layerView.layer.bounds;
    [self.layerView.layer addSublayer:emitter];
    
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"spark"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2;
    
    emitter.emitterCells = @[cell];
}

- (IBAction)didClickTiledImageButton:(id)sender {
    TiledImageViewController *controller = [[TiledImageViewController alloc] initWithNibName:@"TiledImageViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.layerView.layer.bounds;
    
    [self.layerView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);

}

- (void)addTwoCubes {
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    self.layerView.layer.sublayerTransform = pt;
    
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -80, 0, 0);
    CALayer *cube1 = [self cubeWithTransform: c1t];
    [self.layerView.layer addSublayer:cube1];
    
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 80, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer* cube2 = [self cubeWithTransform:c2t];
    
    [self.layerView.layer addSublayer:cube2];
}

- (CALayer*) cubeWithTransform:(CATransform3D)transform {
    CATransformLayer *cube = [CATransformLayer layer];
    
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];

    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];

    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];

    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    CGSize containerSize = self.layerView.layer.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2, containerSize.height / 2);
    
    cube.transform = transform;
    
    return cube;
}

- (CALayer *)faceWithTransform: (CATransform3D) transform {
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    CGFloat red = (rand() / (double) INT_MAX);
    CGFloat green = (rand() / (double) INT_MAX);
    CGFloat blue = (rand() / (double) INT_MAX);
    
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    face.transform = transform;
    return face;
}

- (void)transform2D:(CALayer *)blueLayer {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    transform = CGAffineTransformRotate(transform, M_PI / 6);
    transform = CGAffineTransformTranslate(transform, 50, 0);
    
    blueLayer.affineTransform = transform;
}

- (CALayer *)createBlueLayer {
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = self.layerView.layer.bounds;
    blueLayer.delegate = self;
    blueLayer.cornerRadius = 10.0f;
    
    blueLayer.minificationFilter = kCAFilterNearest;
    
    return blueLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    UIImage *image = [UIImage imageNamed:@"snowman"];
    CGContextDrawImage(ctx, layer.frame, image.CGImage);
}

@end
