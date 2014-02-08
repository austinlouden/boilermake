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
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        // add the image for the person in the detail view
        _image = image;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        imageView.frame = CGRectMake(0.0f,0.0f, 80.0f, 80.0f);
        [self addSubview:imageView];
        
        // labels
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(92.0f, 5.0f, 200.0f, 40.0f)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont fontWithName:@"Avenir-Black" size:18.0f];
        nameLabel.text = [[info objectForKey:@"name"] uppercaseString];
        nameLabel.textColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
        [self addSubview:nameLabel];
        
         
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
