//
//  BMPerson.m
//  Beacon
//
//  Created by Austin Louden on 2/7/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMDetail.h"
#import "BMPerson.h"
#import <QuartzCore/QuartzCore.h>

@implementation BMPerson
@synthesize image = _image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:(2.0f/255.0f) green:(173.0f/255.0f) blue:(234.0f/255.0f) alpha:1.0f];
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        // add the image
        //_image = image;
        //UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        //[self addSubview:imageView];
        
        // gesture recognizer
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
        [recognizer setNumberOfTapsRequired:1];
        [self addGestureRecognizer:recognizer];
        
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)imageTapped
{
    int quadrant = 0;
    
    if (self.frame.origin.y < [self superview].frame.size.width/2) {
        if (self.frame.origin.x < [self superview].frame.size.height/2) quadrant = 2;
        else quadrant = 1;
    } else {
        if (self.frame.origin.x < [self superview].frame.size.height/2) quadrant = 3;
        else quadrant = 4;
    }
    
    NSLog(@"quad = %d", quadrant);
    
    // pull up the image for the user
    //BMDetail *detailView = [[BMDetail alloc] initWithFrame:CGRectMake(100.0f, 100.0f, [self superview].frame.size.height-200.0f, 300.0f)];
    //[[self superview] addSubview:detailView];
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
