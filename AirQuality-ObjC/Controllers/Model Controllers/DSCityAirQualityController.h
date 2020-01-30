//
//  DSCityAirQualityController.h
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSCityAirQualityController : NSObject

+(void)fetchSupportedCountries:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedStatesInCountry:(NSString *)country
                          completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedCitiesInState:(NSString *)state
                           country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion;

+(void)fetchDataForCity:(NSString *)city
                  state:(NSString *)state
                country:(NSString *)country
             completion:(void (^) (DSCityAirQuality *_Nullable))completion;


@end

NS_ASSUME_NONNULL_END
