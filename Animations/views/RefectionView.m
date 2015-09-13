//
//  ReplicatorView.m
//  Animations
//
//  Created by hqin on 15/9/11.
//  Copyright (c) 2015年 hqin. All rights reserved.
//

#import "RefectionView.h"

@implementation RefectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (void)setup {
    CAReplicatorLayer *layer = (CAReplicatorLayer*)self.layer;
    layer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    
    layer.instanceTransform = transform;
    layer.instanceAlphaOffset = -0.6;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

@end
