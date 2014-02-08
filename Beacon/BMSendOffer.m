//
//  BMSendOffer.m
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMSendOffer.h"

@implementation BMSendOffer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        // cancel and send buttons
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sendButton.frame = CGRectMake(118.0f, self.frame.size.height-40, 100.0f, 30.0f);
        sendButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.0f];
        [sendButton setTitle:@"SEND OFFER" forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(sendPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sendButton];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(218.0f, self.frame.size.height-40, 100.0f, 30.0f);
        [cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.0f];
        [cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        // offer image
        UIImageView *offer1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"offer1.jpg"]];
        offer1.frame = CGRectMake(10.0f, 10.0f, self.frame.size.width-20.0f, 550.0f);
        [self addSubview:offer1];
        
        
    }
    return self;
}

- (void)cancelPressed
{
    [self removeFromSuperview];
}

- (void)sendPressed
{
    NSLog(@"send something to the server");
    
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
