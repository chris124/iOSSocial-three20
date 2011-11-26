//
//  InstagramThumbsDataSource.m
//  InstagramMailer
//
//  Created by Christopher White on 11/25/11.
//  Copyright (c) 2011 Mad Races, Inc. All rights reserved.
//

#import "InstagramThumbsDataSource.h"
#import "InstagramUserMediaModel.h"
#import "iOSSLog.h"
#import "InstagramMedia.h"
#import "InstagramMediaCollection.h"

@implementation InstagramThumbsDataSource {
    NSString *nextMaxId;
    NSMutableArray *items;
}

- (id<TTModel>)model 
{
    if (nil == _model) {
        InstagramUserMediaModel *userMediaModel = [[InstagramUserMediaModel alloc] init];

        
        _model = userMediaModel;
        
        return userMediaModel;
    }
    
    return _model;
}

- (BOOL)hasMoreToLoad 
{    
    return nil != nextMaxId;
}

- (void)cancel
{
    [self.model cancel];
}

- (void)invalidate:(BOOL)erase 
{
    [self.model invalidate:erase];
}

/**
 * Informs the data source that its model loaded.
 *
 * That would be a good time to prepare the freshly loaded data for use in the table view.
 */
- (void)tableViewDidLoadModel:(UITableView*)tableView
{
    NSDictionary *response = [(InstagramUserMediaModel*)self.model loadedData];
    
    if (NO == [(InstagramUserMediaModel*)self.model isLoadingMore]) {
        items = [NSMutableArray array];
    }
    
    //NSInteger index = [items count]-1;
    NSInteger index = [items count];
    NSArray *mediaDictionaries = [response objectForKey:@"data"];
    for (NSDictionary *mediaDictionary in mediaDictionaries) {
        InstagramMedia *mediaObject = [[InstagramMedia alloc] initWithDictionary:mediaDictionary];
        mediaObject.index = index;
        mediaObject.photoSource = self.photoSource;
        [items addObject:mediaObject];
        index++;
    }
    
    [(InstagramMediaCollection*)self.photoSource setMedia:items];
    
    nextMaxId = nil;
    NSDictionary *pagination = [response objectForKey:@"pagination"];
    if (pagination) {
        nextMaxId = [pagination objectForKey:@"next_max_id"];
        if (nextMaxId) {
            [(InstagramUserMediaModel*)self.model setNextMaxId:nextMaxId];
        }
    }
}

@end
