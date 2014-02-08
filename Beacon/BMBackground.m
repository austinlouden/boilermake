//
//  BMBackground.m
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMBackground.h"

#define GRIDSIZE 50

@implementation BMBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(249.0f/255.0f) green:(245.0f/255.0f) blue:(237.0f/255.0f) alpha:1.0];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 int width = rect.size.width ;
 int height = rect.size.height ;
 
 int i = 0 ;
 
 
 // Set the color in the current graphics context for future draw operations
 [[UIColor lightGrayColor] setStroke];
 
 // Create our drawing path
 
 UIBezierPath* drawingPath = [UIBezierPath bezierPath];
    drawingPath.lineWidth = 0.3f;
 
 // Draw a grid
 // first the vertical lines
 for( i = 0 ; i <= width ; i=i+GRIDSIZE ) { [drawingPath moveToPoint:CGPointMake(i, 0)];
     [drawingPath addLineToPoint:CGPointMake(i, height)]; } // then the horizontal lines
 for( i = 0 ; i <= height ; i=i+GRIDSIZE ) { [drawingPath moveToPoint:CGPointMake(0, i)]; [drawingPath addLineToPoint:CGPointMake(width, i)]; } // actually draw the grid
 [drawingPath stroke];
    
}




@end
