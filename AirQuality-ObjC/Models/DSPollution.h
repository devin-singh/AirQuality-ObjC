//
//  DSPollution.h
//  AirQuality-ObjC
//
//  Created by Devin Singh on 1/29/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSPollution : NSObject

@property (nonatomic, readonly) NSInteger airQualityIndex;

-(instancetype)initWithInt:(NSInteger) aqi;


@end

@interface DSPollution (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id>*)dictionary;

@end

NS_ASSUME_NONNULL_END
