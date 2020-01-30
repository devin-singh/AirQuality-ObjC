//
//  DSCityAirQuality.h
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSWeather.h"
#import "DSPollution.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString* city;
@property (nonatomic, copy, readonly) NSString* state;
@property (nonatomic, copy, readonly) NSString* country;

@property (nonatomic, copy, readonly) DSWeather* weather;
@property (nonatomic, copy, readonly) DSPollution* pollution;

-(instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(DSWeather *)weather pollution:(DSPollution *)pollution;

@end

@interface DSCityAirQuality (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end



NS_ASSUME_NONNULL_END
