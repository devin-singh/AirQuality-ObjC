//
//  DSCityAirQualityController.m
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

#import "DSCityAirQualityController.h"

static NSString* const baseURLString = @"https://api.airvisual.com/";
static NSString* const versionComponent = @"v2";
static NSString* const countryComponent = @"countries";
static NSString* const stateComponent = @"states";
static NSString* const cityComponent = @"cities";
static NSString* const apiKey = @"365ef6c0-4fce-4db8-b8be-b3d089bc979c";

@implementation DSCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL* baseURL = [NSURL URLWithString:baseURLString];
    NSURL* v2URL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL* countryURL = [v2URL URLByAppendingPathComponent:countryComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:apiKeyQuery];

    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"%@", finalURL);

    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error)
        {
            NSLog(@"Error with URL %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"Error loading data %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        NSDictionary* topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        
        NSDictionary* countriesJSON = topLevelJSON[@"data"];
        
        NSMutableArray<NSString* >* countriesArray = [NSMutableArray new];
        
        for (NSDictionary* currentCountryDictionary in countriesJSON)
        {
            NSString* country = [[NSString alloc] initWithString: currentCountryDictionary[@"country"]];
            [countriesArray addObject:country];
        }
        
        completion(countriesArray);
        
    }] resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL* baseURL = [NSURL URLWithString:baseURLString];
    NSURL* v2URL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL* statesURL = [v2URL URLByAppendingPathComponent:stateComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem* countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem* apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents* urlComponents = [[NSURLComponents alloc] initWithURL:statesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL* finalURL = [urlComponents URL];
    
    NSLog(@"%@", finalURL);
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error with URL %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"Error loading data %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        NSDictionary* topDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:(&error)];
        
        NSDictionary* dataDictionary = topDictionary[@"data"];
        
        NSMutableArray *states = [NSMutableArray new];
        
        for(NSDictionary* stateDict in dataDictionary)
        {
            NSString* state = stateDict[@"state"];
            [states addObject:state];
        }
        
        completion(states);
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    
    NSURL *citiesURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:citiesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            
            NSDictionary *dataDict = topLevel[@"data"];
            NSMutableArray *cities = [NSMutableArray new];
            for (NSDictionary *cityDict in dataDict)
            {
                NSString *city = cityDict[@"city"];
                [cities addObject:city];
            }
            completion(cities);
        }
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(DSCityAirQuality * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:@"city"];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:cityQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            NSDictionary *dataDict = topLevel[@"data"];
            
            DSCityAirQuality* cityAQI = [[DSCityAirQuality alloc] initWithDictionary:dataDict];
            
            completion(cityAQI);
        }
    }] resume];
}

@end
