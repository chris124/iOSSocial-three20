//
//  InstagramUserMediaURLRequest.m
//  InstagramMailer
//
//  Created by Christopher White on 11/25/11.
//  Copyright (c) 2011 Mad Races, Inc. All rights reserved.
//

#import "InstagramUserMediaURLRequest.h"
#import "LocalInstagramUser.h"

@implementation InstagramUserMediaURLRequest 

- (id)initWithUser:(LocalInstagramUser*)localUser 
         nextMaxId:(NSString*)nextMaxId 
          delegate:(id /*<TTURLRequestDelegate>*/)delegate
{
    self = [super initWithURL:nil delegate:delegate];
    if (self) {
        NSMutableString *urlString = [NSMutableString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent", [localUser userId]];

        NSURL *url = [localUser authorizedURL:[NSURL URLWithString:urlString]];
        
        urlString = [NSMutableString stringWithString:[url absoluteString]];
        
        if (nextMaxId) {
            //
            NSString *nextMaxIdParam = [NSString stringWithFormat:@"&max_id=%@", nextMaxId];
            [urlString appendString:nextMaxIdParam];
        }
        
        self.urlPath = urlString;
    }
    return self;
}

- (void)dealloc 
{
    NSLog(@"dealloc");
}

@end
