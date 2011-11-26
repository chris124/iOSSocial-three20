//
//  InstagramMediaCollection.h
//  iOSSocial
//
//  Created by Christopher White on 7/18/11.
//  Copyright 2011 Mad Races, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface InstagramMediaCollection : NSObject <TTPhotoSource>

@property(nonatomic, readwrite, retain) NSString *name;
@property(nonatomic, retain)            NSMutableArray *media;

//- (id)initWithDictionary:(NSDictionary*)collectionDictionary;

@end