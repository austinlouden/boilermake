//
//  BMPerson.m
//  Beacon
//
//  Created by Austin Louden on 2/7/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMDetail.h"
#import "BMPerson.h"
#import "SVPulsingAnnotationView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BMPerson
@synthesize image = _image, info = _info;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // add the image
        SVPulsingAnnotationView *pulseView = [[SVPulsingAnnotationView alloc] initWithNothing];
        pulseView.frame = CGRectMake(0.0f, 0.0f, 25.0f, 25.0f);
        [self addSubview:pulseView];
        
        // gesture recognizer
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
        [recognizer setNumberOfTapsRequired:1];
        [self addGestureRecognizer:recognizer];
        
        [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self
                                       selector:@selector(randomMovement)
                                       userInfo:nil
                                        repeats:YES];
        
    }
    return self;
}

- (void)randomMovement
{
    int r = (arc4random() % 100);
    int adj = (arc4random() % 20)+5;
    NSLog(@"rolled a %d", r);
    // x
    if (r > 50) {
        // +
        if (r > 75) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.frame = CGRectMake(self.frame.origin.x+adj, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            [UIView commitAnimations];
        }
        // -
        else {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.frame = CGRectMake(self.frame.origin.x-adj, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            [UIView commitAnimations];
            
        }
    }
    // y
    else {
        // +
        if (r < 25) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+adj);
            [UIView commitAnimations];
            
        }
        // -
        else {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-adj);
            [UIView commitAnimations];
        }
    }
}

- (void)imageTapped
{
    // remove any other popups from the superview
    for (UIView* view in [[self superview] subviews]) {
        if ([view isKindOfClass:[BMDetail class]])
            [view removeFromSuperview];
    }
    
    // logic to set the frame of the detail view
    int quadrant = 0;
    if (self.frame.origin.y < [self superview].frame.size.width/2) {
        if (self.frame.origin.x < [self superview].frame.size.height/2) quadrant = 2;
        else quadrant = 1;
    } else {
        if (self.frame.origin.x < [self superview].frame.size.height/2) quadrant = 3;
        else quadrant = 4;
    }
    CGRect frame;
    switch (quadrant) {
        case 1:
            frame = CGRectMake(self.frame.origin.x-310.0f, self.frame.origin.y+5, 300.0f, 80.0f);
            break;
        case 2:
            frame = CGRectMake(self.frame.origin.x+42.0f, self.frame.origin.y+5, 300.0f, 80.0f);
            break;
        case 3:
            frame = CGRectMake(self.frame.origin.x+42.0f, self.frame.origin.y-80, 300.0f, 80.0f);
            break;
        case 4:
            frame = CGRectMake(self.frame.origin.x-310.0f, self.frame.origin.y-80, 300.0f, 80.0f);
            break;
            
        default:
            break;
    }
    
    BMDetail *detailView = [[BMDetail alloc] initWithImage:_image info:_info];
    detailView.frame = frame;
    [[self superview] addSubview:detailView];
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
