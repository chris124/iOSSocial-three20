//
//  InstagramMediaCollection.m
//  iOSSocial
//
//  Created by Christopher White on 7/18/11.
//  Copyright 2011 Mad Races, Inc. All rights reserved.
//

#import "InstagramMediaCollection.h"
#import "InstagramMedia.h"
#import "iOSSLog.h"
#import "LocalInstagramUser.h"
#import "iOSSocialServicesStore.h"

@implementation InstagramMediaCollection

@synthesize name;
@synthesize media;
@synthesize title;

- (NSString*)title
{
    return self.name;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index
{
    if ((0 <= index) && (index <= self.maxPhotoIndex)) {
        return [self.media objectAtIndex:index];
    }
    return nil;
}

- (NSInteger)numberOfPhotos
{
    /*
    iOSSLog(@"media count: %d", [self.media count]);
    if (meh) {
        return [self.media count] + 2;
    }
    return [self.media count];
    */
    
    //return -1 since we don't know the exact total number from instagram api
    return -1;
}

- (NSInteger)maxPhotoIndex
{
    iOSSLog(@"media photo index: %d", [self.media count]-1);
    if (self.media) {
        return [self.media count]-1;
    }
    return -1;
    //return [self.media count];
}

/**
 * An array of objects that conform to the TTModelDelegate protocol.
 */
- (NSMutableArray*)delegates
{
    return nil;
}

/**
 * Indicates that the data has been loaded.
 *
 * Default implementation returns YES.
 */
- (BOOL)isLoaded
{
    return YES;
}

/**
 * Indicates that the data is in the process of loading.
 *
 * Default implementation returns NO.
 */
- (BOOL)isLoading
{
    return NO;
}

/**
 * Indicates that the data is in the process of loading additional data.
 *
 * Default implementation returns NO.
 */
- (BOOL)isLoadingMore
{
    return NO;
}

/**
 * Indicates that the model is of date and should be reloaded as soon as possible.
 *
 * Default implementation returns NO.
 */
-(BOOL)isOutdated
{
    return NO;
}

/**
 * Loads the model.
 *
 * Default implementation does nothing.
 */
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    
}

/**
 * Cancels a load that is in progress.
 *
 * Default implementation does nothing.
 */
- (void)cancel
{
    
}

/**
 * Invalidates data stored in the cache or optionally erases it.
 *
 * Default implementation does nothing.
 */
- (void)invalidate:(BOOL)erase
{
    
}

@end