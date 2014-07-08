//
//  Client.m
//  test
//
//  Created by Ольга Королева on 08.07.14.
//  Copyright (c) 2014 Ольга Королева. All rights reserved.
//

#import "Client.h"

#define URL @"https://dl.dropboxusercontent.com/u/39826174/Images/images.txt"

@implementation Client

- (void)getDataWithSuccess:(SuccessBlock)successBlock failure:(ErrorBlock)errorBlock {
    NSURL *url = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Error loading data: %@", connectionError);
            if (errorBlock) {
                errorBlock(connectionError);
            }
        } else if (data) {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *urls = [dataString componentsSeparatedByString:@";"];
            successBlock(urls);
        } else {
            NSDictionary* errorDict = @{
                NSLocalizedDescriptionKey: @"Empty data",
                NSURLErrorKey: url
            };
            NSError *emptyDataError = [NSError errorWithDomain:@"TEST_DOMAIN" code:0xABBA userInfo:errorDict];
            errorBlock(emptyDataError);
        }
    }];
    
}



@end
