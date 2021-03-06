//
//  InstagramUserMediaModel.h
//  InstagramMailer
//
//  Created by Christopher White on 11/25/11.
//  Copyright (c) 2011 Mad Races, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface InstagramUserMediaModel : TTURLRequestModel

@property(nonatomic, strong)    NSString    *nextMaxId;

- (NSDictionary*)loadedData;

@end
