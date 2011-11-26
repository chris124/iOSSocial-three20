//
//  InstagramUserMediaURLRequest.h
//  InstagramMailer
//
//  Created by Christopher White on 11/25/11.
//  Copyright (c) 2011 Mad Races, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@class LocalInstagramUser;

@interface InstagramUserMediaURLRequest : TTURLRequest

- (id)initWithUser:(LocalInstagramUser*)localUser 
         nextMaxId:(NSString*)nextMaxId 
          delegate:(id /*<TTURLRequestDelegate>*/)delegate;

@end
