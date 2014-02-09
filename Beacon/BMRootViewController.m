//
//  BMRootViewController.m
//  Beacon
//
//  Created by Austin Louden on 2/7/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMRootViewController.h"
#import "BMPerson.h"
#import "BMBeacon.h"
#import "BMBackground.h"
#import "BMSendOffer.h"
#import "BMHTTPClient.h"
#import <MapKit/MapKit.h>
#include <stdlib.h>

#define PERSON_SIZE 50.0f
#define BEACON_SIZE 30.0f

@interface BMRootViewController ()
{
    UIScrollView *scrollView;
    int currentLocation;
}

@end

@implementation BMRootViewController
@synthesize liveDevices = _liveDevices;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(249.0f/255.0f) green:(245.0f/255.0f) blue:(237.0f/255.0f) alpha:1.0];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.height, self.view.frame.size.height)];
    scrollView.contentSize = CGSizeMake(2200.0f, 1600.0f);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
    recognizer.delegate = self;
    [scrollView addGestureRecognizer:recognizer];
    
    BMBackground *background = [[BMBackground alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2200.0f, 1600.0f)];
    [scrollView addSubview:background];
    
    UILabel *engageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.height-180.0f, self.view.frame.size.width-60.0f, 230.0f, 35.0f)];
    engageLabel.text = @"E N G A G E";
    engageLabel.textColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    engageLabel.font = [UIFont fontWithName:@"Avenir-Black" size:24.0f];
    engageLabel.layer.shadowColor = [engageLabel.textColor CGColor];
    engageLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    engageLabel.layer.shadowRadius = 0.5;
    engageLabel.layer.shadowOpacity = 0.5;
    [self.view addSubview:engageLabel];
    
    // Buttons
    // Broadcast
    UIImage *blast = [UIImage imageNamed:@"blast.png"];
    UIButton *blastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [blastButton setBackgroundImage:blast forState:UIControlStateNormal];
    [blastButton addTarget:self action:@selector(blastPressed) forControlEvents:UIControlEventTouchUpInside];
    blastButton.frame = CGRectMake(60, 700, 40, 40);
    blastButton.alpha = 0.8f;
    [self.view addSubview:blastButton];
    
    // Heatmap
    UIImage *heat = [UIImage imageNamed:@"heatmap.png"];
    UIButton *heatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [heatButton setBackgroundImage:heat forState:UIControlStateNormal];
    [heatButton addTarget:self action:@selector(heatPressed) forControlEvents:UIControlEventTouchUpInside];
    heatButton.frame = CGRectMake(130, 700, 40, 40);
    heatButton.alpha = 0.8f;
    [self.view addSubview:heatButton];
    
    // Stats
    UIImage *stats = [UIImage imageNamed:@"stats.png"];
    UIButton *statsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [statsButton setBackgroundImage:stats forState:UIControlStateNormal];
    [statsButton addTarget:self action:@selector(statsPressed) forControlEvents:UIControlEventTouchUpInside];
    statsButton.frame = CGRectMake(205, 699, 38, 39);
    statsButton.alpha = 0.8f;
    [self.view addSubview:statsButton];
    
    // the random walk
    NSDictionary *info = @{@"name": @"Austin Louden", @"email": @"austinlouden@gmail.com"};
    UIImage *image1 = [UIImage imageNamed:@"AUSTIN_small.png"];
    
    NSArray *startingPoints = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:CGPointMake(1335.0, 397.0)],[NSValue valueWithCGPoint:CGPointMake(1734, 228)], [NSValue valueWithCGPoint:CGPointMake(1503, 404)], [NSValue valueWithCGPoint:CGPointMake(1267.0f, 682.0f)], [NSValue valueWithCGPoint:CGPointMake(1405.0f, 860.0f)],[NSValue valueWithCGPoint:CGPointMake(1729.0f, 829.0f)], nil];
    
    int tag = 41;
    for (NSValue *value in startingPoints) {
        CGPoint origin = [value CGPointValue];
        BMPerson *person = [[BMPerson alloc] initWithFrame:CGRectMake(origin.x, origin.y, PERSON_SIZE, PERSON_SIZE)];
        person.image = image1;
        person.tag = tag;
        person.info = info;
        [scrollView addSubview:person];
        tag++;
    }
    
    NSArray *beaconPoints = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:CGPointMake(1221, 638)], [NSValue valueWithCGPoint:CGPointMake(1680.0, 640.0)], [NSValue valueWithCGPoint:CGPointMake(1449, 225)], nil];
    
    int beaconCount = 4;
    for (NSValue *value in beaconPoints) {
        CGPoint origin = [value CGPointValue];
        BMBeacon *beacon = [[BMBeacon alloc] initWithTitle:[NSString stringWithFormat:@"BEACON %d", beaconCount]];
        beacon.frame = CGRectMake(origin.x, origin.y, BEACON_SIZE, BEACON_SIZE);
        [scrollView addSubview:beacon];
        beaconCount++;
    }
    
    
    BMBeacon *beacon1 = [[BMBeacon alloc] initWithTitle:@"BEACON 1"];
    beacon1.frame = CGRectMake(100.0f, 175.0f, 80.0f, 50.0f);
    beacon1.tag = 1;
    [scrollView addSubview:beacon1];
    
    BMBeacon *beacon2 = [[BMBeacon alloc] initWithTitle:@"BEACON 2"];
    beacon2.frame = CGRectMake(480.0f, 175.0f, 80.0f, 50.0f);
    beacon2.tag = 2;
    [scrollView addSubview:beacon2];
    
    BMBeacon *beacon3 = [[BMBeacon alloc] initWithTitle:@"BEACON 3"];
    beacon3.frame = CGRectMake(580.0f, 564.0f, 80.0f, 50.0f);
    beacon3.tag = 3;
    [scrollView addSubview:beacon3];
    
    BMBeacon *entranceBeacon = [[BMBeacon alloc] initWithTitle:@"BEACON 7"];
    entranceBeacon.frame = CGRectMake(200.0f, 980.0f, 80.0f, 50.0f);
    [scrollView addSubview:entranceBeacon];
    
     //networking
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(getDevices)
                                   userInfo:nil
                                    repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:25.0
                                    target:self
                                    selector:@selector(animatePeople)
                                    userInfo:nil
                            repeats:YES];
    
    
    [self animatePeople];
    
    
}

- (CABasicAnimation *)translateAnimationFromPoint:(CGPoint)point1 toPoint:(CGPoint)point2 withDuraction:(float)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:duration];
    [animation setFromValue:[NSValue valueWithCGPoint:point1]];
    animation.toValue = [NSValue valueWithCGPoint:point2];
    return animation;
}

- (void)animatePeople
{
    
    BMPerson *person1 = (BMPerson*)[self.view viewWithTag:41];
    CABasicAnimation *a1 = [self translateAnimationFromPoint:CGPointMake(1365.0, 297.0) toPoint:CGPointMake(1365.0, 557.0) withDuraction:2.0f]; // down
    CABasicAnimation *a2 = [self translateAnimationFromPoint:CGPointMake(1365.0, 557.0) toPoint:CGPointMake(1585.0, 557.0) withDuraction:2.0f]; // right
    CABasicAnimation *a3 = [self translateAnimationFromPoint:CGPointMake(1585.0, 557.0) toPoint:CGPointMake(1585.0, 800.0) withDuraction:2.0f]; // down
    
    CABasicAnimation *s1 = [self translateAnimationFromPoint:CGPointMake(1585.0, 800.0) toPoint:CGPointMake(1585.0, 800.0) withDuraction:4.0f]; // stay
    
    CABasicAnimation *b3 = [self translateAnimationFromPoint:CGPointMake(1585.0, 800.0) toPoint:CGPointMake(1585.0, 557.0) withDuraction:2.0f]; // up
    CABasicAnimation *b2 = [self translateAnimationFromPoint:CGPointMake(1585.0, 557.0) toPoint:CGPointMake(1365.0, 557.0) withDuraction:2.0f]; // left
    CABasicAnimation *b1 = [self translateAnimationFromPoint:CGPointMake(1365.0, 557.0) toPoint:CGPointMake(1365.0, 297.0) withDuraction:2.0f]; // up
    a2.beginTime = 2.0f;
    a3.beginTime = 4.0f;
    s1.beginTime = 6.0f;
    b3.beginTime = 10.0f;
    b2.beginTime = 12.0f;
    b1.beginTime = 14.0f;
    
    CAAnimationGroup *anim = [CAAnimationGroup animation];
    [anim setAnimations:[NSArray arrayWithObjects:a1, a2, a3, s1, b3, b2, b1, nil]];
    [anim setDuration:16.0];
    [anim setRemovedOnCompletion:NO];
    [anim setFillMode:kCAFillModeForwards];
    [person1.layer addAnimation:anim forKey:nil];
    
    ///////////////////
    
    BMPerson *person2 = (BMPerson*)[self.view viewWithTag:42];
    CABasicAnimation *ss0 = [self translateAnimationFromPoint:CGPointMake(1375.0, 800.0) toPoint:CGPointMake(1375.0, 800.0) withDuraction:2.0f]; // stay
    CABasicAnimation *aa1 = [self translateAnimationFromPoint:CGPointMake(1375.0, 800.0) toPoint:CGPointMake(1375.0, 257.0) withDuraction:7.0f]; // up
    CABasicAnimation *ss1 = [self translateAnimationFromPoint:CGPointMake(1375.0, 257.0) toPoint:CGPointMake(1375.0, 257.0) withDuraction:5.0f]; // stay
    CABasicAnimation *bb1 = [self translateAnimationFromPoint:CGPointMake(1375.0, 257.0) toPoint:CGPointMake(1375.0, 800.0) withDuraction:7.0f]; // down
    aa1.beginTime = 2.0f;
    ss1.beginTime = 9.0f;
    bb1.beginTime = 14.0f;
    
    CAAnimationGroup *aanim = [CAAnimationGroup animation];
    [aanim setAnimations:[NSArray arrayWithObjects:ss0, aa1, ss1, bb1, nil]];
    [aanim setDuration:21.0];
    [aanim setRemovedOnCompletion:NO];
    [aanim setFillMode:kCAFillModeForwards];
    [person2.layer addAnimation:aanim forKey:nil];
    
    ///////////////////
    
    BMPerson *person3 = (BMPerson*)[self.view viewWithTag:43];
    CABasicAnimation *sss1 = [self translateAnimationFromPoint:CGPointMake(1800.0, 800.0) toPoint:CGPointMake(1800.0, 800.0) withDuraction:4.0f]; // stay
    CABasicAnimation *aaa1 = [self translateAnimationFromPoint:CGPointMake(1800.0, 800.0) toPoint:CGPointMake(1800.0, 550.0) withDuraction:4.0f]; // up
    CABasicAnimation *sss2 = [self translateAnimationFromPoint:CGPointMake(1800.0, 550.0) toPoint:CGPointMake(1800.0, 550.0) withDuraction:4.0f]; // stay
    CABasicAnimation *aaa2 = [self translateAnimationFromPoint:CGPointMake(1800.0, 550.0) toPoint:CGPointMake(1570.0, 550.0) withDuraction:2.0f]; // left
    CABasicAnimation *aaa3 = [self translateAnimationFromPoint:CGPointMake(1570.0, 550.0) toPoint:CGPointMake(1570.0, 700.0) withDuraction:2.0f]; // down
    
    CABasicAnimation *bbb3 = [self translateAnimationFromPoint:CGPointMake(1570.0, 700.0) toPoint:CGPointMake(1570.0, 550.0) withDuraction:2.0f]; // up
    CABasicAnimation *bbb2 = [self translateAnimationFromPoint:CGPointMake(1570.0, 550.0) toPoint:CGPointMake(1800.0, 550.0) withDuraction:2.0f]; // right
    CABasicAnimation *bbb1 = [self translateAnimationFromPoint:CGPointMake(1800.0, 550.0) toPoint:CGPointMake(1800.0, 800.0) withDuraction:4.0f]; // down
    aaa1.beginTime = 4.0f;
    sss2.beginTime = 8.0f;
    aaa2.beginTime = 12.0f;
    aaa3.beginTime = 14.0f;
    bbb3.beginTime = 16.0f;
    bbb2.beginTime = 18.0f;
    bbb1.beginTime = 20.0f;
    
    CAAnimationGroup *aaanim = [CAAnimationGroup animation];
    [aaanim setAnimations:[NSArray arrayWithObjects:sss1, aaa1, sss2, aaa2, aaa3, bbb3, bbb2, bbb1, nil]];
    [aaanim setDuration:24.0];
    [aaanim setRemovedOnCompletion:NO];
    [aaanim setFillMode:kCAFillModeForwards];
    [person3.layer addAnimation:aaanim forKey:nil];
    
    ////////////////////
    
    BMPerson *person4 = (BMPerson*)[self.view viewWithTag:44];
    CABasicAnimation *aaaa1 = [self translateAnimationFromPoint:CGPointMake(1590.0, 350.0) toPoint:CGPointMake(1590.0, 800.0) withDuraction:4.0f];
    CABasicAnimation *aaaa2 = [self translateAnimationFromPoint:CGPointMake(1590.0, 800.0) toPoint:CGPointMake(1590.0, 550.0) withDuraction:2.0f];
    CABasicAnimation *aaaa3 = [self translateAnimationFromPoint:CGPointMake(1590.0, 550.0) toPoint:CGPointMake(1370.0, 550.0) withDuraction:2.0f];
    CABasicAnimation *aaaa4 = [self translateAnimationFromPoint:CGPointMake(1370.0, 550.0) toPoint:CGPointMake(1370.0, 850.0) withDuraction:2.0f];
    CABasicAnimation *bbbb1 = [self translateAnimationFromPoint:CGPointMake(1370.0, 850.0) toPoint:CGPointMake(1370.0, 550.0) withDuraction:2.0f];
    CABasicAnimation *bbbb2 = [self translateAnimationFromPoint:CGPointMake(1370.0, 550.0) toPoint:CGPointMake(1590.0, 550.0) withDuraction:2.0f];
    CABasicAnimation *bbbb3 = [self translateAnimationFromPoint:CGPointMake(1590.0, 550.0) toPoint:CGPointMake(1590.0, 350.0) withDuraction:2.0f];
    aaaa2.beginTime = 4.0f;
    aaaa3.beginTime = 6.0f;
    aaaa4.beginTime = 8.0f;
    bbbb1.beginTime = 10.0f;
    bbbb2.beginTime = 12.0f;
    bbbb3.beginTime = 14.0f;
    
    CAAnimationGroup *aaaanim = [CAAnimationGroup animation];
    [aaaanim setAnimations:[NSArray arrayWithObjects:aaaa1, aaaa2, aaaa3, aaaa4, bbbb1, bbbb2, bbbb3, nil]];
    [aaaanim setDuration:16.0];
    [aaaanim setRemovedOnCompletion:NO];
    [aaaanim setFillMode:kCAFillModeForwards];
    [person4.layer addAnimation:aaaanim forKey:nil];
    
    ////////////////////////
    
    BMPerson *person5 = (BMPerson*)[self.view viewWithTag:45];
    CABasicAnimation *aaaaa1 = [self translateAnimationFromPoint:CGPointMake(1590.0, 550.0) toPoint:CGPointMake(1800.0, 550.0) withDuraction:3.0f];
    CABasicAnimation *sssss1 = [self translateAnimationFromPoint:CGPointMake(1800.0, 550.0) toPoint:CGPointMake(1800.0, 550.0) withDuraction:4.0f];
    CABasicAnimation *aaaaa2 = [self translateAnimationFromPoint:CGPointMake(1800.0, 550.0) toPoint:CGPointMake(1800.0, 350.0) withDuraction:2.0f];
    CABasicAnimation *sssss2 = [self translateAnimationFromPoint:CGPointMake(1800.0, 350.0) toPoint:CGPointMake(1800.0, 350.0) withDuraction:2.0f];
    CABasicAnimation *bbbbb2 = [self translateAnimationFromPoint:CGPointMake(1800.0, 350.0) toPoint:CGPointMake(1800.0, 550.0) withDuraction:4.0f];
    CABasicAnimation *bbbbb1 = [self translateAnimationFromPoint:CGPointMake(1800.0, 550.0) toPoint:CGPointMake(1590.0, 550.0) withDuraction:4.0f];
    sssss1.beginTime = 3.0f;
    aaaaa2.beginTime = 7.0f;
    sssss2.beginTime = 9.0f;
    bbbbb2.beginTime = 11.0f;
    bbbbb1.beginTime = 15.0f;
    
    CAAnimationGroup *aaaaanim = [CAAnimationGroup animation];
    [aaaaanim setAnimations:[NSArray arrayWithObjects:aaaaa1, sssss1, aaaaa2, sssss2, bbbbb2, bbbbb1, nil]];
    [aaaaanim setDuration:19.0];
    [aaaaanim setRemovedOnCompletion:NO];
    [aaaaanim setFillMode:kCAFillModeForwards];
    [person5.layer addAnimation:aaaaanim forKey:nil];
    
    ///////////////////////////
    
    BMPerson *person6 = (BMPerson*)[self.view viewWithTag:46];
    CABasicAnimation *ssssss1 = [self translateAnimationFromPoint:CGPointMake(1590.0, 800.0) toPoint:CGPointMake(1590.0, 800.0) withDuraction:1.0f];
    CABasicAnimation *aaaaaa1 = [self translateAnimationFromPoint:CGPointMake(1590.0, 800.0) toPoint:CGPointMake(1590.0, 550.0) withDuraction:4.0f];
    CABasicAnimation *ssssss2 = [self translateAnimationFromPoint:CGPointMake(1590.0, 550.0) toPoint:CGPointMake(1590.0, 550.0) withDuraction:4.0f];
    CABasicAnimation *bbbbbb1 = [self translateAnimationFromPoint:CGPointMake(1590.0, 550.0) toPoint:CGPointMake(1590.0, 800.0) withDuraction:2.0f];
    aaaaaa1.beginTime = 1.0f;
    ssssss2.beginTime = 5.0f;
    bbbbbb1.beginTime = 9.0f;
    
    CAAnimationGroup *aaaaaanim = [CAAnimationGroup animation];
    [aaaaaanim setAnimations:[NSArray arrayWithObjects:ssssss1, aaaaaa1, ssssss2, bbbbbb1, nil]];
    [aaaaaanim setDuration:11.0];
    [aaaaaanim setRemovedOnCompletion:NO];
    [aaaaaanim setFillMode:kCAFillModeForwards];
    [person6.layer addAnimation:aaaaaanim forKey:nil];
}

- (void)blastPressed
{
    BMSendOffer *sendOffer = [[BMSendOffer alloc] initWithFrame:CGRectMake(600.0f, 50.0f, 400.0f, 680.0f)];
    [scrollView addSubview:sendOffer];
    
}

- (void)heatPressed
{
    NSLog(@"heat pressed ");
}

- (void)statsPressed
{
    NSLog(@"stats pressed");
    
}

- (void)testSwitch
{
    BMPerson *person = (BMPerson*)[self.view viewWithTag:15];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    person.frame = CGRectMake(110.0f, 145.0f, PERSON_SIZE, PERSON_SIZE);
    [UIView commitAnimations];
    
}

- (void)getDevices
{
    [[BMHTTPClient sharedClient] GET:@"getLocation.php" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (!_liveDevices) {
            _liveDevices = responseObject;
            for (NSDictionary *device in _liveDevices) {
                
                // determine the frame based on [device objectForKey:@"location"]
                CGRect frame;
                int location = [[device objectForKey:@"location"] integerValue];
                currentLocation = location;
                switch (location) {
                    case 1:
                        frame = CGRectMake(110.0f+(arc4random() % 30), 145.0f, PERSON_SIZE, PERSON_SIZE);
                        break;
                    case 2:
                        frame = CGRectMake(480.0f+(arc4random() % 30), 145.0f, PERSON_SIZE, PERSON_SIZE);
                        break;
                    default:
                        break;
                }
                
                NSDictionary *info = @{@"name": @"Austin Louden", @"email": @"austinlouden@gmail.com"};
                UIImage *image1 = [UIImage imageNamed:@"AUSTIN_small.png"];
                
                if(location > 0 && location < 3) {
                    BMPerson *person = [[BMPerson alloc] initWithFrame:frame];
                    person.tag = 15;
                    person.image = image1;
                    person.info = info;
                    [scrollView addSubview:person];
                }
            }
        }
        else {
            int location = [[[responseObject objectAtIndex:0] objectForKey:@"location"] integerValue];
            if (location != currentLocation) {
                if (location == 1) {
                    BMPerson *person = (BMPerson*)[self.view viewWithTag:15];
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1.0];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                    person.frame = CGRectMake(110.0f, 145.0f, PERSON_SIZE, PERSON_SIZE);
                    [UIView commitAnimations];
                    currentLocation = location;
                }
                else {
                    BMPerson *person = (BMPerson*)[self.view viewWithTag:15];
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1.0];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                    person.frame = CGRectMake(480.0f, 145.0f, PERSON_SIZE, PERSON_SIZE);
                    [UIView commitAnimations];
                    currentLocation = location;
                }
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error: %@", error);
    }];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:scrollView];
    NSLog(@"%@", NSStringFromCGPoint(location));
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
