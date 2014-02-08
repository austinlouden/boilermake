//
//  BMRootViewController.m
//  Beacon
//
//  Created by Austin Louden on 2/7/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMRootViewController.h"
#import "BMPerson.h"
#import <MapKit/MapKit.h>

#define PERSON_SIZE 25.0f

@interface BMRootViewController ()

@end

@implementation BMRootViewController

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
    
    // beacon code to get devices in range goes here
    
    // for each device in range, create a BMPerson and add it to the subview
    
    NSDictionary *info = @{@"name": @"Austin Louden", @"email": @"austinlouden@gmail.com"};
    
    BMPerson *person1 = [[BMPerson alloc] initWithFrame:CGRectMake(100.0f, 100.0f, PERSON_SIZE, PERSON_SIZE)];
    UIImage *image1 = [UIImage imageNamed:@"AUSTIN_small.png"];
    person1.image = image1;
    person1.info = info;
    [self.view addSubview:person1];
    
    BMPerson *person2 = [[BMPerson alloc] initWithFrame:CGRectMake(100.0f, 500.0f, PERSON_SIZE, PERSON_SIZE)];
    UIImage *image2 = [UIImage imageNamed:@"AUSTIN_small.png"];
    person2.image = image2;
    person2.info = info;
    [self.view addSubview:person2];
    
    BMPerson *person3 = [[BMPerson alloc] initWithFrame:CGRectMake(700.0f, 500.0f, PERSON_SIZE, PERSON_SIZE)];
    UIImage *image3 = [UIImage imageNamed:@"AUSTIN_small.png"];
    person3.image = image3;
    person3.info = info;
    [self.view addSubview:person3];
    
    BMPerson *person4 = [[BMPerson alloc] initWithFrame:CGRectMake(700.0f, 100.0f, PERSON_SIZE, PERSON_SIZE)];
    UIImage *image4 = [UIImage imageNamed:@"AUSTIN_small.png"];
    person4.image = image4;
    person4.info = info;
    [self.view addSubview:person4];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
