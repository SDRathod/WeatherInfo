//
//  LocationModel.h
//  WeatherApp
//
//  Created by Samir Rathod on 15/11/17.
//  Copyright (c) 2017 Samir Rathod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject {
    NSString *strLocationName;
    double latitude;
    double longitude;
    NSString *strCity;
    NSString *strCountry;
}

@property (nonatomic,strong) NSString *strLocationName;
@property (nonatomic,strong) NSString *strCity;
@property (nonatomic,strong) NSString *strCountry;

@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;

- (id)init;

@end
