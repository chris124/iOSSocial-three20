//
//  InstagramURLJSONResponse.m
//  InstagramMailer
//
//  Created by Christopher White on 11/25/11.
//  Copyright (c) 2011 Mad Races, Inc. All rights reserved.
//

#import "InstagramURLJSONResponse.h"
#import "iOSSLog.h"
#import "three20/three20.h"

@interface IOSSOAuth2ParserClass : NSObject
// just enough of SBJSON to be able to parse
- (id)objectWithString:(NSString*)repr error:(NSError**)error;
- (id)objectWithString:(NSString*)repr;
@end


@interface InstagramURLJSONResponse ()

@property (nonatomic, readwrite, strong) NSDictionary* dictionary;

@end


@implementation InstagramURLJSONResponse {
    NSDictionary* _dictionary;
}

@synthesize dictionary = _dictionary;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc 
{
    NSLog(@"dealloc");
}

+ (id)JSONFromData:(NSData*)data
{
    id obj = nil;
    NSError *error = nil;
    
    Class serializer = NSClassFromString(@"NSJSONSerialization");
    if (serializer) {
        const NSUInteger kOpts = (1UL << 0); // NSJSONReadingMutableContainers
        obj = [serializer JSONObjectWithData:data
                                     options:kOpts
                                       error:&error];
#if DEBUG
        if (error) {
            //NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //iOSSLog(@"NSJSONSerialization error %@ parsing %@", error, str);
        }
#endif
        return obj;
    } else {
        // try SBJsonParser or SBJSON
        Class jsonParseClass = NSClassFromString(@"SBJsonParser");
        if (!jsonParseClass) {
            jsonParseClass = NSClassFromString(@"SBJSON");
        }
        if (jsonParseClass) {
            IOSSOAuth2ParserClass *parser = [[jsonParseClass alloc] init];
            NSString *jsonStr = [[NSString alloc] initWithData:data
                                                      encoding:NSUTF8StringEncoding];
            if (jsonStr) {
                if ([parser respondsToSelector:@selector(objectWithString:error:)]) {
                    obj = [parser objectWithString:jsonStr error:&error];
                } else {
                    obj = [parser objectWithString:jsonStr];
                }
#if DEBUG
                if (error) {
                    iOSSLog(@"%@ error %@ parsing %@", NSStringFromClass(jsonParseClass),
                            error, jsonStr);
                }
#endif
                return obj;
            }
        }
    }
    return nil;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTURLResponse


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response
               data:(id)data {
    
    // This response is designed for NSData objects, so if we get anything else it's probably a
    // mistake.
    TTDASSERT([data isKindOfClass:[NSData class]]);
    TTDASSERT(nil == _dictionary);
    
    if ([data isKindOfClass:[NSData class]]) {
        //_data = [data retain];
        NSDictionary *jsonDictionary = [InstagramURLJSONResponse JSONFromData:data];
        if (jsonDictionary) {
            _dictionary = jsonDictionary;
        } else {
            return [NSError errorWithDomain:kTTNetworkErrorDomain
                                       code:kTTNetworkErrorCodeInvalidImage
                                   userInfo:nil];
        }
    }
    
    return nil;
}

@end
