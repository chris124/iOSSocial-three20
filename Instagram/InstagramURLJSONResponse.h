//
//  InstagramURLJSONResponse.h
//  InstagramMailer
//
//  Created by Christopher White on 11/25/11.
//  Copyright (c) 2011 Mad Races, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20Network/TTURLResponse.h"

@interface InstagramURLJSONResponse : NSObject <TTURLResponse>

@property (nonatomic, readonly, strong) NSDictionary* dictionary;

@end
