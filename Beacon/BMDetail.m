//
//  BMDetail.m
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMDetail.h"
#import "BMSendOffer.h"
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
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(92.0f, 2.0f, 200.0f, 40.0f)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont fontWithName:@"Avenir-Black" size:18.0f];
        nameLabel.text = [[info objectForKey:@"name"] uppercaseString];
        nameLabel.textColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
        [self addSubview:nameLabel];
        
        UIButton *emailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        emailButton.frame = CGRectMake(190.0f, 52.0f, 100.0f, 30.0f);
        emailButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.0f];
        [emailButton setTitle:@"SEND EMAIL" forState:UIControlStateNormal];
        [emailButton addTarget:self action:@selector(emailPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emailButton];
        
        UIButton *offerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        offerButton.frame = CGRectMake(87.0f, 52.0f, 100.0f, 30.0f);
        [offerButton setTitle:@"SEND OFFER" forState:UIControlStateNormal];
        offerButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.0f];
        [offerButton addTarget:self action:@selector(offerPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:offerButton];
        
        UILabel *sinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(92.0f, 32.0f, 200.0f, 30.0f)];
        sinceLabel.backgroundColor = [UIColor clearColor];
        sinceLabel.font = [UIFont fontWithName:@"Avenir-Black" size:13.0f];
        sinceLabel.text = @"MEMBER SINCE: 02/08/14";
        sinceLabel.textColor = [UIColor colorWithWhite:0.4f alpha:1.0f];
        [self addSubview:sinceLabel];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        closeButton.frame = CGRectMake(270.0f, 5.0f, 20.0f, 20.0f);
        closeButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
        [closeButton setTitle:@"x" forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
         
    }
    
    return self;
}

- (void)closePressed
{
    [self removeFromSuperview];
}

- (void)emailPressed
{
    NSLog(@"email pressed");
}

- (void)offerPressed
{
    BMSendOffer *sendOffer = [[BMSendOffer alloc] initWithFrame:CGRectMake(600.0f, 50.0f, 400.0f, 680.0f)];
    [[self superview] addSubview:sendOffer];
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
