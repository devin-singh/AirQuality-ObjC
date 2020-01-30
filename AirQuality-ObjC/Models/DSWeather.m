//
//  DSWeather.m
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

#import "DSWeather.h"

@implementation DSWeather

- (instancetype)initWithWeatherInfo:(NSInteger)temperature humidity:(NSInteger)humidity windSpeed:(NSInteger)windSpeed
{
    self = [super init];
    
    if (self)
    {
        _temperature = temperature;
        _humidity = humidity;
        _windSpeed = windSpeed;
    }
    
    return self;
}

@end

@implementation DSWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger temperature = [dictionary[@"tp"] intValue];
    NSInteger humidity = [dictionary[@"hu"] intValue];
    NSInteger windSpeed = [dictionary[@"ws"] intValue];

    return [self initWithWeatherInfo:temperature humidity:humidity windSpeed:windSpeed];
}

@end
