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
    
    BMBackground *background = [[BMBackground alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.height, self.view.frame.size.width)];
    [self.view addSubview:background];
    
    // TODO:
    // on startup, query the server. for each user (response.length), create a BMPerson object, set the UUID and location.
    // every N seconds, query the server, and for each live BMPerson, check if person.location is different than what you currently have.
    // if isn't, do nothing. if it is, update the info we have, and perform an animation.
    
    // for each device in range, create a BMPerson and add it to the subview
    
    NSDictionary *info = @{@"name": @"Austin Louden", @"email": @"austinlouden@gmail.com"};
    
    
    BMPerson *person1 = [[BMPerson alloc] initWithFrame:CGRectMake(260.0f, 120.0f, PERSON_SIZE, PERSON_SIZE)];
    UIImage *image1 = [UIImage imageNamed:@"AUSTIN_small.png"];
    person1.image = image1;
    person1.info = info;
    //[self.view addSubview:person1];
    
    /*
    BMPerson *person2 = [[BMPerson alloc] initWithFrame:CGRectMake(100.0f, 420.0f, PERSON_SIZE, PERSON_SIZE)];
    UIImage *image2 = [UIImage imageNamed:@"AUSTIN_small.png"];
    person2.image = image2;
    person2.info = info;
    [self.view addSubview:person2];
    
    BMPerson *person3 = [[BMPerson alloc] initWithFrame:CGRectMake(700.0f, 636.0f, PERSON_SIZE, PERSON_SIZE)];
    UIImage *image3 = [UIImage imageNamed:@"AUSTIN_small.png"];
    person3.image = image3;
    person3.info = info;
    [self.view addSubview:person3];
    
    BMPerson *person4 = [[BMPerson alloc] initWithFrame:CGRectMake(700.0f, 150.0f, PERSON_SIZE, PERSON_SIZE)];
    UIImage *image4 = [UIImage imageNamed:@"AUSTIN_small.png"];
    person4.image = image4;
    person4.info = info;
    [self.view addSubview:person4];
     */
     
    
    BMBeacon *beacon1 = [[BMBeacon alloc] initWithTitle:@"BEACON 1"];
    beacon1.frame = CGRectMake(100.0f, 175.0f, 80.0f, 50.0f);
    [self.view addSubview:beacon1];
    
    BMBeacon *beacon2 = [[BMBeacon alloc] initWithTitle:@"BEACON 2"];
    beacon2.frame = CGRectMake(480.0f, 175.0f, 80.0f, 50.0f);
    [self.view addSubview:beacon2];
    
    BMBeacon *beacon3 = [[BMBeacon alloc] initWithTitle:@"BEACON 3"];
    beacon3.frame = CGRectMake(580.0f, 564.0f, 80.0f, 50.0f);
    [self.view addSubview:beacon3];
    
    /* networking
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(getDevices)
                                   userInfo:nil
                                    repeats:YES];
     */
    
    
    // test
    UIButton *test = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [test setTitle:@"Switch" forState:UIControlStateNormal];
    test.frame = CGRectMake(0.0f, 0.0f, 80.0f, 30.0f);
    [test addTarget:self action:@selector(testSwitch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
    [self getDevices];
    
    
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
        //NSLog(@"%@", responseObject);
        if (!_liveDevices) {
            _liveDevices = responseObject;
            for (NSDictionary *device in _liveDevices) {
                
                // determine the frame based on [device objectForKey:@"location"]
                CGRect frame;
                int location = [[device objectForKey:@"location"] integerValue];
                switch (location) {
                    case 1:
                        frame = CGRectMake(110.0f+(arc4random() % 30), 145.0f, PERSON_SIZE, PERSON_SIZE);
                        NSLog(@"frame: %@", NSStringFromCGRect(frame));
                        break;
                    case 2:
                        frame = CGRectMake(480.0f+(arc4random() % 30), 145.0f, PERSON_SIZE, PERSON_SIZE);
                        NSLog(@"frame: %@", NSStringFromCGRect(frame));
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
                    [self.view addSubview:person];
                }
            }
        }
        else {
            for (NSDictionary *device in responseObject) {
                int uuid = [[device objectForKey:@"uuid"] integerValue];
                int location = [[device objectForKey:@"location"] integerValue];
                for(NSDictionary *liveDevice in _liveDevices) {
                    if (uuid == [[liveDevice objectForKey:@"uuid"] integerValue] && location == [[liveDevice objectForKey:@"location"] integerValue]) {
                        return;
                    }
                    else {
                        
                        if (location == 1) {
                            BMPerson *person = (BMPerson*)[self.view viewWithTag:15];
                            [UIView beginAnimations:nil context:nil];
                            [UIView setAnimationDuration:1.0];
                            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                            person.frame = CGRectMake(110.0f, 145.0f, PERSON_SIZE, PERSON_SIZE);
                            [UIView commitAnimations];
                        }
                        else {
                            BMPerson *person = (BMPerson*)[self.view viewWithTag:15];
                            [UIView beginAnimations:nil context:nil];
                            [UIView setAnimationDuration:1.0];
                            [UIView setAnimationDelay:1.0f];
                            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                            person.frame = CGRectMake(480.0f, 145.0f, PERSON_SIZE, PERSON_SIZE);
                            [UIView commitAnimations];
                        }
                    }
                }
            }
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error: %@", error);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
