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
    
    NSArray *beaconPoints = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:CGPointMake(1165, 640)], [NSValue valueWithCGPoint:CGPointMake(1395, 640)], [NSValue valueWithCGPoint:CGPointMake(1630.0, 640.0)], [NSValue valueWithCGPoint:CGPointMake(1860, 640.0)], [NSValue valueWithCGPoint:CGPointMake(1265, 485)], [NSValue valueWithCGPoint:CGPointMake(1495, 485)], [NSValue valueWithCGPoint:CGPointMake(1730.0, 485)], [NSValue valueWithCGPoint:CGPointMake(1960, 485)], [NSValue valueWithCGPoint:CGPointMake(1165, 185)], [NSValue valueWithCGPoint:CGPointMake(1395, 185)], [NSValue valueWithCGPoint:CGPointMake(1630.0, 185)], [NSValue valueWithCGPoint:CGPointMake(1860, 185 )], [NSValue valueWithCGPoint:CGPointMake(1265, 940)], [NSValue valueWithCGPoint:CGPointMake(1495, 940)], [NSValue valueWithCGPoint:CGPointMake(1730.0, 940)], [NSValue valueWithCGPoint:CGPointMake(1960, 940)], nil];
    
    int beaconCount = 8;
    for (NSValue *value in beaconPoints) {
        CGPoint origin = [value CGPointValue];
        BMBeacon *beacon = [[BMBeacon alloc] initWithTitle:[NSString stringWithFormat:@"BEACON %d", beaconCount]];
        beacon.frame = CGRectMake(origin.x, origin.y, BEACON_SIZE, BEACON_SIZE);
        [scrollView addSubview:beacon];
        beaconCount++;
    }
    
    
    BMBeacon *beacon1 = [[BMBeacon alloc] initWithTitle:@"BEACON 1"];
    beacon1.frame = CGRectMake(105.0f, 235.0f, 80.0f, 50.0f);
    beacon1.tag = 1;
    [scrollView addSubview:beacon1];
    
    BMBeacon *beacon2 = [[BMBeacon alloc] initWithTitle:@"BEACON 2"];
    beacon2.frame = CGRectMake(406.5f, 235.0f, 80.0f, 50.0f);
    beacon2.tag = 2;
    [scrollView addSubview:beacon2];
    
    BMBeacon *beacon3 = [[BMBeacon alloc] initWithTitle:@"BEACON 3"];
    beacon3.frame = CGRectMake(706.5f, 235.0f, 80.0f, 50.0f);
    beacon3.tag = 3;
    [scrollView addSubview:beacon3];
    
    BMBeacon *beacon4 = [[BMBeacon alloc] initWithTitle:@"BEACON 4"];
    beacon4.frame = CGRectMake(1006.5f, 235.0f, 80.0f, 50.0f);
    beacon4.tag = 3;
    [scrollView addSubview:beacon4];
    
    BMBeacon *beacon1b = [[BMBeacon alloc] initWithTitle:@"BEACON 1"];
    beacon1b.frame = CGRectMake(105.0f, 755.0f, 80.0f, 50.0f);
    beacon1b.tag = 1;
    [scrollView addSubview:beacon1b];
    
    BMBeacon *beacon2b = [[BMBeacon alloc] initWithTitle:@"BEACON 2"];
    beacon2b.frame = CGRectMake(406.5f, 755.0f, 80.0f, 50.0f);
    beacon2b.tag = 2;
    [scrollView addSubview:beacon2b];
    
    BMBeacon *beacon3b = [[BMBeacon alloc] initWithTitle:@"BEACON 3"];
    beacon3b.frame = CGRectMake(706.5f, 755.0f, 80.0f, 50.0f);
    beacon3b.tag = 3;
    [scrollView addSubview:beacon3b];
    
    BMBeacon *beacon4b = [[BMBeacon alloc] initWithTitle:@"BEACON 4"];
    beacon4b.frame = CGRectMake(1006.5f, 755.0f, 80.0f, 50.0f);
    beacon4b.tag = 3;
    [scrollView addSubview:beacon4b];
    
    BMBeacon *beacon1c = [[BMBeacon alloc] initWithTitle:@"BEACON 1"];
    beacon1c.frame = CGRectMake(105.0f, 1015.0f, 80.0f, 50.0f);
    beacon1c.tag = 1;
    [scrollView addSubview:beacon1c];
    
    BMBeacon *beacon2c = [[BMBeacon alloc] initWithTitle:@"BEACON 2"];
    beacon2c.frame = CGRectMake(406.5f, 1015.0f, 80.0f, 50.0f);
    beacon2c.tag = 2;
    [scrollView addSubview:beacon2c];
    
    BMBeacon *beacon3c = [[BMBeacon alloc] initWithTitle:@"BEACON 3"];
    beacon3c.frame = CGRectMake(706.5f, 1015.0f, 80.0f, 50.0f);
    beacon3c.tag = 3;
    [scrollView addSubview:beacon3c];
    
    BMBeacon *beacon4c = [[BMBeacon alloc] initWithTitle:@"BEACON 4"];
    beacon4c.frame = CGRectMake(1006.5f, 1015.0f, 80.0f, 50.0f);
    beacon4c.tag = 3;
    [scrollView addSubview:beacon4c];

    BMBeacon *entranceBeacon = [[BMBeacon alloc] initWithTitle:@"BEACON 7"];
    entranceBeacon.frame = CGRectMake(230.0f, 440.0f, 80.0f, 50.0f);
    [scrollView addSubview:entranceBeacon];
    
    BMBeacon *entranceBeacon2 = [[BMBeacon alloc] initWithTitle:@"BEACON 7"];
    entranceBeacon2.frame = CGRectMake(530.0f, 440.0f, 80.0f, 50.0f);
    [scrollView addSubview:entranceBeacon2];
    
    BMBeacon *entranceBeacon3 = [[BMBeacon alloc] initWithTitle:@"BEACON 7"];
    entranceBeacon3.frame = CGRectMake(830.0f, 440.0f, 80.0f, 50.0f);
    [scrollView addSubview:entranceBeacon3];
    
    BMBeacon *entranceBeacona = [[BMBeacon alloc] initWithTitle:@"BEACON 7"];
    entranceBeacona.frame = CGRectMake(330.0f, 550.0f, 80.0f, 50.0f);
    [scrollView addSubview:entranceBeacona];
    
    BMBeacon *entranceBeacon2a = [[BMBeacon alloc] initWithTitle:@"BEACON 7"];
    entranceBeacon2a.frame = CGRectMake(630.0f, 550.0f, 80.0f, 50.0f);
    [scrollView addSubview:entranceBeacon2a];
    
    BMBeacon *entranceBeacon3a = [[BMBeacon alloc] initWithTitle:@"BEACON 7"];
    entranceBeacon3a.frame = CGRectMake(930.0f, 550.0f, 80.0f, 50.0f);
    [scrollView addSubview:entranceBeacon3a];
    
     //networking
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(getDevices)
                                   userInfo:nil
                                    repeats:YES];
    
    [self animatePeople];
    
    
}

- (void)animatePeople
{
    BMPerson *person1 = (BMPerson*)[self.view viewWithTag:41];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:8.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    person1.frame = CGRectMake(1335.0f, 550.0f, PERSON_SIZE, PERSON_SIZE);
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelay:8.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    person1.frame = CGRectMake(1585.0f, 550.0f, PERSON_SIZE, PERSON_SIZE);
    [UIView commitAnimations];
    
    /*[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelay:9.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    person1.frame = CGRectMake(1585.0f, 950.0f, PERSON_SIZE, PERSON_SIZE);
    [UIView commitAnimations];*/
    
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
