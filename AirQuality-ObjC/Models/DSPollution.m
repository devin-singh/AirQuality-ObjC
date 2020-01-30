//
//  DSPollution.m
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

#import "DSPollution.h"

@implementation DSPollution

- (instancetype)initWithInt:(NSInteger)aqi
{
    self = [super init];
    
    if (self)
    {
        _airQualityIndex = aqi;
    }
    
    return self;
}

@end

@implementation DSPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"] intValue];
    
    return [self initWithInt:aqi];
}

@end
