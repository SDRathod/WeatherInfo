//
//  Singleton.h
//  WeatherApp
//
//  Created by Samir Rathod on 15/11/17.
//  Copyright (c) 2017 Samir Rathod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
+ (Singleton *)sharedSingleton;
- (NSString *)removeNull:(NSString *)str;
@end
