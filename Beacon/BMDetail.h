//
//  BMDetail.h
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMDetail : UIView
@property (nonatomic, strong) UIImage *image;
- (id)initWithImage:(UIImage *)image info:(NSDictionary *)info;
@end
