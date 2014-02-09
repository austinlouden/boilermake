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
#import "BMHTTPClient.h"
#import <MapKit/MapKit.h>
#include <stdlib.h>

#define PERSON_SIZE 25.0f
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
    scrollView.contentSize = CGSizeMake(2000.0f, 1400.0f);
    [self.view addSubview:scrollView];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
    recognizer.delegate = self;
    [scrollView addGestureRecognizer:recognizer];
    
    BMBackground *background = [[BMBackground alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2000.0f, 1300.0f)];
    [scrollView addSubview:background];
    
    UILabel *engageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.height-115.0f, self.view.frame.size.width-35.0f, 115.0f, 35.0f)];
    engageLabel.text = @"E N G A G E";
    engageLabel.textColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    engageLabel.font = [UIFont fontWithName:@"Avenir-Black" size:18.0f];
    [self.view addSubview:engageLabel];
    
    
    
    // the random walk
    NSDictionary *info = @{@"name": @"Austin Louden", @"email": @"austinlouden@gmail.com"};
    UIImage *image1 = [UIImage imageNamed:@"AUSTIN_small.png"];
    
    NSArray *startingPoints = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:CGPointMake(1265.0, 397.0)],[NSValue valueWithCGPoint:CGPointMake(1734, 228)], [NSValue valueWithCGPoint:CGPointMake(1503, 404)], [NSValue valueWithCGPoint:CGPointMake(1267.0f, 682.0f)], [NSValue valueWithCGPoint:CGPointMake(1405.0f, 860.0f)],[NSValue valueWithCGPoint:CGPointMake(1729.0f, 829.0f)], nil];
    
    for (NSValue *value in startingPoints) {
        CGPoint origin = [value CGPointValue];
        BMPerson *person = [[BMPerson alloc] initWithFrame:CGRectMake(origin.x, origin.y, PERSON_SIZE, PERSON_SIZE)];
        person.image = image1;
        person.info = info;
        [scrollView addSubview:person];
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
