//
//  LocationModel.m
//  WeatherApp
//
//  Created by Samir Rathod on 15/11/17.
//  Copyright (c) 2017 Samir Rathod. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel
@synthesize  strLocationName,latitude,longitude,strCity,strCountry;

- (id)init {
    LocationModel *unshared = [super init];
    return unshared;
}

//-(id)initWithParameter : (NSString *)strAddress lat : (double)latitude1 lng : (double)longitude1 {
//    LocationModel *unshared = [super init];
//    self.strLocationName = strAddress;
//    self.latitude = latitude1;
//    self.longitude = longitude1;
//    return unshared;
//}

@end
