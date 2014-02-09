//
//  BMBeacon.m
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMBeacon.h"
#import "BMProgrammer.h"
#import "BMDetail.h"
#import "SVPulsingAnnotationView.h"

@implementation BMBeacon
@synthesize title = _title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithTitle:(NSString*)title
{
    if (self = [super init]) {
        
        _title = title;
        
        // add the image
        SVPulsingAnnotationView *pulseView = [[SVPulsingAnnotationView alloc] initWithNothing];
        pulseView.frame = CGRectMake(26.0f, 0.0f, 15.0f, 15.0f);
        [pulseView setAnnotationColor:[UIColor colorWithRed:(237/255.0f) green:(129/255.0f) blue:(43/255.0f) alpha:0.3f]];
        pulseView.pulseScaleFactor = 17.0f + (arc4random() % 8);
        NSTimeInterval interval = (arc4random() % 3);
        int64_t delayInSeconds = (arc4random() % 3);
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [pulseView setDelayBetweenPulseCycles:interval];
            [self addSubview:pulseView];
        });
        
        // add the label
//        UILabel *beaconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 12.0f, 80.0f, 30.0f)];
//        beaconLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.0f];
//        beaconLabel.text = title;
//        beaconLabel.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
//        [self addSubview:beaconLabel];
        
        // gesture recognizer
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
        [recognizer setNumberOfTapsRequired:1];
        [self addGestureRecognizer:recognizer];
        
    }
    
    return self;
    
}

- (void)imageTapped
{
    // remove any other popups from the superview
    for (UIView* view in [[self superview] subviews]) {
        if ([view isKindOfClass:[BMDetail class]])
            [view removeFromSuperview];
    }
    
    BMProgrammer *detailView = [[BMProgrammer alloc] initWithBeacon:self];
    detailView.frame = CGRectMake(600.0f, 50.0f, 400.0f, 680.0f);
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
