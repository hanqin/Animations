//
//  TiledImageViewController.m
//  Animations
//
//  Created by hqin on 15/9/11.
//  Copyright (c) 2015年 hqin. All rights reserved.
//

#import "TiledImageViewController.h"

@interface TiledImageViewController () <UIScrollViewDelegate>

@property(nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation TiledImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATiledLayer *tiledLayer = [CATiledLayer layer];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    tiledLayer.frame = CGRectMake(0, 0, 4000 / scale, 3000 / scale);
    tiledLayer.delegate = self;
    tiledLayer.contentsScale = scale;
    tiledLayer.tileSize = CGSizeMake(250, 250);
    [self.scrollView.layer addSublayer:tiledLayer];
    
    self.scrollView.contentSize = tiledLayer.frame.size;
    
    [tiledLayer setNeedsDisplay];
}

- (void)dealloc {
    [self.scrollView.layer.sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if ([obj isKindOfClass: [CATiledLayer class]]) {
            ((CATiledLayer *)obj).delegate = nil;
            *stop = YES;
        }
    }];
}

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx {
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    CGFloat scale = [UIScreen mainScreen].scale;

    NSInteger x = floor(bounds.origin.x / layer.tileSize.width * scale);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height * scale);
    
    NSString* imageName = [NSString stringWithFormat:@"scene-%li-%li", (long)y, (long)x];
    NSString* imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpeg" inDirectory:@"scene"];
    
    NSLog(@"displaying %@, found %@", imageName, imagePath ? @"YES" : @"NO");
    
    UIImage *tiledImage = [UIImage imageWithContentsOfFile:imagePath];
    UIGraphicsPushContext(ctx);
    [tiledImage drawInRect:bounds];
    UIGraphicsPopContext();
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
