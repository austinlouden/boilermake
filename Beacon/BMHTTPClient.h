//
//  BMHTTPClient.h
//  Beacon
//
//  Created by Austin Louden on 2/8/14.
//  Copyright (c) 2014 Austin Louden. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface BMHTTPClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
