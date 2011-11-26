//
//  InstagramUserMediaModel.m
//  InstagramMailer
//
//  Created by Christopher White on 11/25/11.
//  Copyright (c) 2011 Mad Races, Inc. All rights reserved.
//

#import "InstagramUserMediaModel.h"
#import "InstagramUserMediaURLRequest.h"
#import "InstagramURLJSONResponse.h"
#import "LocalInstagramUser.h"
#import "iOSSocialServicesStore.h"

@implementation InstagramUserMediaModel {
    InstagramUserMediaURLRequest *request;
    InstagramURLJSONResponse *response;
}

@synthesize nextMaxId;

- (void)dealloc
{
    NSLog(@"dealloc");
}

/**
 * Loads the model.
 *
 * Default implementation does nothing.
 */
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{    
    if (NO == more) {
        nextMaxId = nil;
        _isLoadingMore = NO;
    } else {
        _isLoadingMore = YES;
    }
    
    request = [[InstagramUserMediaURLRequest alloc] initWithUser:(LocalInstagramUser*)[[iOSSocialServicesStore sharedServiceStore] defaultAccount] 
                                                       nextMaxId:nextMaxId 
                                                        delegate:self];
    response = [[InstagramURLJSONResponse alloc] init];
    request.response = response;
    request.cachePolicy = TTURLRequestCachePolicyNetwork;
    [[TTURLRequestQueue mainQueue] sendRequest:request];
}

- (NSDictionary*)loadedData
{
    return response.dictionary;
}

@end
