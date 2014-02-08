//
//  BMHTTPClient.m
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "BMHTTPClient.h"

static NSString * const BMBaseURLString = @"http://50.116.28.96/beacon/";

@implementation BMHTTPClient

+ (instancetype)sharedClient {
    static BMHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BMHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BMBaseURLString]];
    });
    
    return _sharedClient;
}

@end
