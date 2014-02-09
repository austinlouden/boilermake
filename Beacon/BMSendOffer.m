//
//  BMSendOffer.m
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMSendOffer.h"
#import "BMHTTPClient.h"

@interface BMSendOffer()
{
    UIImageView *imageView;
    int toggle;
}

@end

@implementation BMSendOffer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        UILabel *selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 18.0f, self.frame.size.width, 40.0f)];
        selectLabel.text = @" SELECT AN OFFER";
        selectLabel.font = [UIFont fontWithName:@"Avenir-Black" size:20.0f];
        selectLabel.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        selectLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:selectLabel];
        
        //left and right buttons
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        leftButton.frame = CGRectMake(70.f, 23.0f, 30.0f, 30.0f);
        leftButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:24.0f];
        [leftButton setTitle:@"<" forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(switchPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftButton];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        rightButton.frame = CGRectMake(305.f, 23.0f, 30.0f, 30.0f);
        rightButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:24.0f];
        [rightButton setTitle:@">" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(switchPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
        
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
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"offer1.jpg"]];
        imageView.frame = CGRectMake(10.0f, 65.0f, self.frame.size.width-20.0f, 550.0f);
        [self addSubview:imageView];
        
        toggle = 1;
        
        
    }
    return self;
}

- (void)switchPressed
{
    if (toggle == 1) {
        imageView.image = [UIImage imageNamed:@"offer2.jpg"];
        toggle = 2;
    }
    else {
        imageView.image = [UIImage imageNamed:@"offer1.jpg"];
        toggle = 1;
    }
}

- (void)cancelPressed
{
    [self removeFromSuperview];
}

- (void)sendPressed
{
    [[BMHTTPClient sharedClient] POST:@"ipadReceive.php" parameters:@{@"uuid": @50, @"promoId": @1} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        [self removeFromSuperview];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error: %@", error);
    }];
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
