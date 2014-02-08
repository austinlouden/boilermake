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
        
        UILabel *table1 = [[UILabel alloc] initWithFrame:CGRectMake(735.0f, 194.0f, 250.0f, 50.0f)];
        table1.text = @"AISLE 1";
        table1.textAlignment = NSTextAlignmentCenter;
        table1.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
        table1.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table1];
        
        UILabel *table2 = [[UILabel alloc] initWithFrame:CGRectMake(735.0f, 324.0f, 250.0f, 50.0f)];
        table2.text = @"AISLE 2";
        table2.textAlignment = NSTextAlignmentCenter;
        table2.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
        table2.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table2];
        
        UILabel *table3 = [[UILabel alloc] initWithFrame:CGRectMake(735.0f, 454.0f, 250.0f, 50.0f)];
        table3.text = @"AISLE 3";
        table3.textAlignment = NSTextAlignmentCenter;
        table3.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
        table3.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table3];
        
        UILabel *table4 = [[UILabel alloc] initWithFrame:CGRectMake(735.0f, 584.0f, 250.0f, 50.0f)];
        table4.text = @"AISLE 4";
        table4.textAlignment = NSTextAlignmentCenter;
        table4.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
        table4.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table4];
        
        UILabel *entrance = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 250.0f, 50.0f)];
        entrance.text = @"ENTRANCE";
        entrance.textAlignment = NSTextAlignmentCenter;
        entrance.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
        entrance.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:entrance];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int width = rect.size.width;
    int height = rect.size.height;
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
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, (235.0f/255.0f), (223.0f/255.0f), (200.0f/255.0f), 1.0);
    CGContextSetRGBStrokeColor(context, (202.0f/255.0f), (188.0f/255.0f), (167.0f/255.0f), 1.0);
    for (int i=0;i<3;i++) {
        for (int j=0;j<4;j++) {
            CGRect rectangle = CGRectMake(60+255*i, 193+130*j, 250, 50);
            CGPathRef path = CGPathCreateWithRect(rectangle, NULL);
            CGContextAddPath(context, path);
            CGContextDrawPath(context, kCGPathFillStroke);
            CGPathRelease(path);
        }
    }
    
    
    //draw some tables
/*
    
    CGRect rectangle2 = CGRectMake(300, 193, 250, 50);
    CGPathRef path2 = CGPathCreateWithRect(rectangle2, NULL);
    CGContextSetRGBFillColor(context, (235.0f/255.0f), (223.0f/255.0f), (200.0f/255.0f), 1.0);
    CGContextSetRGBStrokeColor(context, (202.0f/255.0f), (188.0f/255.0f), (167.0f/255.0f), 1.0);
    CGContextAddPath(context, path2);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path2);
    
    CGRect rectangle3 = CGRectMake(560, 193, 250, 50);
    CGPathRef path3 = CGPathCreateWithRect(rectangle3, NULL);
    CGContextSetRGBFillColor(context, (235.0f/255.0f), (223.0f/255.0f), (200.0f/255.0f), 1.0);
    CGContextSetRGBStrokeColor(context, (202.0f/255.0f), (188.0f/255.0f), (167.0f/255.0f), 1.0);
    CGContextAddPath(context, path3);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path3);
 */

    

}




@end
