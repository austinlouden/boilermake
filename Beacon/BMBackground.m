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
        
        UILabel *table1 = [[UILabel alloc] initWithFrame:CGRectMake(245.0f, 480.0f, 150.0f, 50.0f)];
        table1.text = @"BREAD";
        table1.adjustsFontSizeToFitWidth = YES;
        table1.textAlignment = NSTextAlignmentCenter;
        table1.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table1.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table1];
        
        UILabel *table2 = [[UILabel alloc] initWithFrame:CGRectMake(545.0f, 480.0f, 150.0f, 50.0f)];
        table2.text = @"CHEESE";
        table2.adjustsFontSizeToFitWidth = YES;
        table2.textAlignment = NSTextAlignmentCenter;
        table2.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table2.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table2];
        
        UILabel *table3 = [[UILabel alloc] initWithFrame:CGRectMake(845.0f, 480.0f, 150.0f, 50.0f)];
        table3.text = @"COOKIES";
        table3.adjustsFontSizeToFitWidth = YES;
        table3.textAlignment = NSTextAlignmentCenter;
        table3.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table3.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table3];
        
        UILabel *table4 = [[UILabel alloc] initWithFrame:CGRectMake(735.0f, 764.0f, 250.0f, 50.0f)];
        table4.text = @"AISLE 4";
        table4.textAlignment = NSTextAlignmentCenter;
        table4.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
        table4.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table4];
        
//        UILabel *entrance = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 1070.0f, 250.0f, 50.0f)];
//        entrance.text = @"ENTRANCE";
//        entrance.textAlignment = NSTextAlignmentCenter;
//        entrance.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
//        entrance.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
//        [self addSubview:entrance];
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
    drawingPath.lineWidth = 0.5f;
 
 // Draw a grid
 // first the vertical lines
 for( i = 0 ; i <= width ; i=i+GRIDSIZE ) { [drawingPath moveToPoint:CGPointMake(i, 0)];
     [drawingPath addLineToPoint:CGPointMake(i, height)]; } // then the horizontal lines
 for( i = 0 ; i <= height ; i=i+GRIDSIZE ) { [drawingPath moveToPoint:CGPointMake(0, i)]; [drawingPath addLineToPoint:CGPointMake(width, i)]; } // actually draw the grid
 [drawingPath stroke];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.5f);
    CGContextSetRGBFillColor(context, (235.0f/255.0f), (223.0f/255.0f), (200.0f/255.0f), 1.0);
    CGContextSetRGBStrokeColor(context, (202.0f/255.0f), (188.0f/255.0f), (167.0f/255.0f), 1.0);
    for (int i=0;i<3;i++) {
        for (int j=0;j<4;j++) {
            if( j != 1) {
                CGRect rectangle = CGRectMake(200+300*i-60, 193+260*j, 300, 100);
                CGPathRef path = CGPathCreateWithRect(rectangle, NULL);
                CGContextAddPath(context, path);
                CGContextDrawPath(context, kCGPathFillStroke);
                CGPathRelease(path);
            }
        }
    }
    
    for (int i=0;i<2;i++) {
        for (int j=0;j<4;j++) {
            CGRect rectangle = CGRectMake(1200+230*j, 193+455*i, 100, 300);
            CGPathRef path = CGPathCreateWithRect(rectangle, NULL);
            CGContextAddPath(context, path);
            CGContextDrawPath(context, kCGPathFillStroke);
            CGPathRelease(path);
        }
    }
    
  //  CGRect bounds = [self bounds];
    
//    CGPoint center;
//    center.x = bounds.origin.x + bounds.size.width / 2.0;
//    center.y = bounds.origin.y + bounds.size.height / 2.0;
//    CGContextSetRGBFillColor(context, (235.0f/255.0f), (223.0f/255.0f), (200.0f/255.0f), 1.0);
//    CGContextSetRGBStrokeColor(context, (202.0f/255.0f), (188.0f/255.0f), (167.0f/255.0f), 1.0);
//    CGContextSetLineWidth(context, 2.0);
//    CGContextFillEllipseInRect (context, borderRect);
//    CGContextStrokeEllipseInRect(context, borderRect);
//    CGContextFillPath(context);
    
    
    for (int j = 0; j<3; j++) {
        CGRect box = CGRectMake(220+j*300, 400, 200, 200);
        UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:box];
        ballBezierPath.lineWidth = 3.0f;
        [ballBezierPath stroke];
        [ballBezierPath fill];
        [self setBackgroundColor:[UIColor clearColor]]; // Happens with and without this line
    }
    

}




@end
