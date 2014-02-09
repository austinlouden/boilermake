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
        
        UILabel *table4 = [[UILabel alloc] initWithFrame:CGRectMake(465.0f, 220.0f, 250.0f, 50.0f)];
        table4.text = @"BEVERAGES";
        table4.adjustsFontSizeToFitWidth = YES;
        table4.textAlignment = NSTextAlignmentCenter;
        table4.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table4.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table4];
        
        UILabel *table5 = [[UILabel alloc] initWithFrame:CGRectMake(465.0f, 740.0f, 250.0f, 50.0f)];
        table5.text = @"FROZEN GOODS";
        table5.adjustsFontSizeToFitWidth = YES;
        table5.textAlignment = NSTextAlignmentCenter;
        table5.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table5.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table5];
        
        UILabel *table6 = [[UILabel alloc] initWithFrame:CGRectMake(465.0f, 1000.0f, 250.0f, 50.0f)];
        table6.text = @"CANNED GOODS";
        table6.adjustsFontSizeToFitWidth = YES;
        table6.textAlignment = NSTextAlignmentCenter;
        table6.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table6.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table6];
        
        UILabel *table7 = [[UILabel alloc] initWithFrame:CGRectMake(1130.0f, 325.0f, 250.0f, 50.0f)];
        table7.text = @"WINE";
        [table7 setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        table7.adjustsFontSizeToFitWidth = YES;
        table7.textAlignment = NSTextAlignmentCenter;
        table7.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table7.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table7];
        
        UILabel *table8 = [[UILabel alloc] initWithFrame:CGRectMake(1355.0f, 325.0f, 250.0f, 50.0f)];
        table8.text = @"CHIPS";
        [table8 setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        table8.adjustsFontSizeToFitWidth = YES;
        table8.textAlignment = NSTextAlignmentCenter;
        table8.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table8.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table8];
        
        UILabel *table9 = [[UILabel alloc] initWithFrame:CGRectMake(1585.0f, 325.0f, 250.0f, 50.0f)];
        table9.text = @"CANDY";
        [table9 setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        table9.adjustsFontSizeToFitWidth = YES;
        table9.textAlignment = NSTextAlignmentCenter;
        table9.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table9.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table9];
        
        UILabel *table10 = [[UILabel alloc] initWithFrame:CGRectMake(1815.0f, 325.0f, 250.0f, 50.0f)];
        table10.text = @"FLORAL";
        [table10 setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        table10.adjustsFontSizeToFitWidth = YES;
        table10.textAlignment = NSTextAlignmentCenter;
        table10.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table10.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table10];
        
        
        // DOWN
        
        UILabel *table7b = [[UILabel alloc] initWithFrame:CGRectMake(1130.0f, 780.0f, 250.0f, 50.0f)];
        table7b.text = @"BEER";
        [table7b setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        table7b.adjustsFontSizeToFitWidth = YES;
        table7b.textAlignment = NSTextAlignmentCenter;
        table7b.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table7b.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table7b];
        
        UILabel *table8b = [[UILabel alloc] initWithFrame:CGRectMake(1355.0f, 780.0f, 250.0f, 50.0f)];
        table8b.text = @"LIQUOR";
        [table8b setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        table8b.adjustsFontSizeToFitWidth = YES;
        table8b.textAlignment = NSTextAlignmentCenter;
        table8b.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table8b.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table8b];
        
        UILabel *table9b = [[UILabel alloc] initWithFrame:CGRectMake(1585.0f, 780.0f, 250.0f, 50.0f)];
        table9b.text = @"CLEANING";
        [table9b setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        table9b.adjustsFontSizeToFitWidth = YES;
        table9b.textAlignment = NSTextAlignmentCenter;
        table9b.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table9b.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table9b];
        
        UILabel *table10b = [[UILabel alloc] initWithFrame:CGRectMake(1815.0f, 780.0f, 250.0f, 50.0f)];
        table10b.text = @"TOILETRIES";
        [table10b setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        table10b.adjustsFontSizeToFitWidth = YES;
        table10b.textAlignment = NSTextAlignmentCenter;
        table10b.font = [UIFont fontWithName:@"Avenir-Black" size:30.0f];
        table10b.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:table10b];
        
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
