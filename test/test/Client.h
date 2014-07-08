//
//  Client.h
//  test
//
//  Created by Ольга Королева on 08.07.14.
//  Copyright (c) 2014 Ольга Королева. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(NSArray* result);
typedef void (^ErrorBlock)(NSError* error);

@interface Client : NSObject<NSURLConnectionDelegate>

- (void)getDataWithSuccess:(SuccessBlock)successBlock failure:(ErrorBlock)errorBlock;

@end
