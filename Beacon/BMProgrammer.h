//
//  BMProgrammer.h
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMBeacon.h"

@interface BMProgrammer : UIView
@property (nonatomic, strong) BMBeacon *beacon;
- (id)initWithBeacon:(BMBeacon *)beacon;
@end
