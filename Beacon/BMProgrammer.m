//
//  BMProgrammer.m
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMProgrammer.h"
#import "BMBeacon.h"

@interface BMProgrammer()
{
    UILabel *select2;
    UIImageView *imageView;
    int toggle;
}
@end

@implementation BMProgrammer
@synthesize beacon = _beacon;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithBeacon:(BMBeacon*)beacon
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        _beacon = beacon;
        
        UILabel *selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 10.0f, 180.0f, 40.0f)];
        selectLabel.text = _beacon.title;
        selectLabel.font = [UIFont fontWithName:@"Avenir-Black" size:22.0f];
        selectLabel.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        selectLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:selectLabel];
        
        UILabel *autoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 70.0f, 380.0f, 80.0f)];
        autoLabel.text = @"AUTOMATICALLY SEND OFFERS \nTO CUSTOMERS IN BEACON RANGE";
        autoLabel.numberOfLines = 0;
        autoLabel.font = [UIFont fontWithName:@"Avenir-Black" size:16.0f];
        autoLabel.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        autoLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:autoLabel];
        
        // cancel and send buttons
        UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        saveButton.frame = CGRectMake(95.0f, 620.0f, 100.0f, 30.0f);
        saveButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:18.0f];
        [saveButton setTitle:@"SAVE" forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(savePressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:saveButton];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(195.0f, 620.0f, 100.0f, 30.0f);
        [cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:18.0f];
        [cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        UISwitch *autopilot = [[UISwitch alloc] initWithFrame:CGRectMake(315.0f, 90.0f, 10.0f, 10.0f)];
        [autopilot addTarget:self action:@selector(autopilotEngaged) forControlEvents:UIControlEventValueChanged];
        [self addSubview:autopilot];
        
        select2 = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 120.0f, 380.0f, 80.0f)];
        select2.text = @"SELECT AN OFFER";
        select2.numberOfLines = 0;
        select2.font = [UIFont fontWithName:@"Avenir-Black" size:16.0f];
        select2.textColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        select2.textAlignment = NSTextAlignmentLeft;
        select2.hidden = YES;
        [self addSubview:select2];
        
        // offer image
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"offer1.jpg"]];
        imageView.frame = CGRectMake(15.0f, 180.0f, 300.0f, 400.0f);
        imageView.hidden = YES;
        [self addSubview:imageView];
        
        toggle = 1;
        
        
        
    }
    
    return self;
    
}

- (void)savePressed
{
    [self removeFromSuperview];
    
}



- (void)cancelPressed
{
    [self removeFromSuperview];
}

- (void)autopilotEngaged
{
    if(select2.hidden) {
        select2.hidden = NO;
        imageView.hidden = NO;
    }
    else {
        select2.hidden = YES;
        imageView.hidden = YES;
    }


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
