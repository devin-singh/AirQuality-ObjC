//
//  DSCityAirQuality.m
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

#import "DSCityAirQuality.h"

@implementation DSCityAirQuality
- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(DSWeather *)weather pollution:(DSPollution *)pollution
{
    self = [super init];
    
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    
    return self;
}
@end

@implementation DSCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    NSDictionary *currentInfo = dictionary[@"current"];
    
    DSWeather *weather = [[DSWeather alloc] initWithDictionary:currentInfo[@"weather"]];
    DSPollution *pollution = [[DSPollution alloc] initWithDictionary:currentInfo[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
