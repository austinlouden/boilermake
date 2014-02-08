//
//  BMDetail.m
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMDetail.h"
#import <QuartzCore/QuartzCore.h>

@implementation BMDetail
@synthesize image = _image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithImage:(UIImage *)image info:(NSDictionary *)info
{
    if (self = [super init]) {
        
        // background and border
        self.backgroundColor = [UIColor colorWithWhite:0.95f alpha:0.8f];
        self.layer.borderColor = [UIColor colorWithWhite:0.5f alpha:1.0f].CGColor;
        self.layer.borderWidth = 1.0f;
        
        // add the image for the person in the detail view
        _image = image;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.layer.borderColor = [UIColor colorWithWhite:0.5f alpha:1.0f].CGColor;
        imageView.layer.borderWidth = 1.0f;
        imageView.frame = CGRectMake(6.0f, 6.0f, 80.0f, 80.0f);
        [self addSubview:imageView];
         
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
