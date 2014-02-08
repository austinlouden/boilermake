//
//  BMBeacon.h
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMBeacon : UIView
@property (nonatomic, strong) NSString *title;
@property BOOL autopilot;
@property int selectedOffer;
- (id)initWithTitle:(NSString*)title;
@end
