//
//  Singleton.m
//  WeatherApp
//
//  Created by Samir Rathod on 15/11/17.
//  Copyright (c) 2017 Samir Rathod. All rights reserved.
//

#import "Singleton.h"
#import <UIKit/UIKit.h>
#import "Global.h"

@implementation Singleton

static Singleton *singletonObj = NULL;

+ (Singleton *)sharedSingleton {
    @synchronized(self) {
        if (singletonObj == NULL)
            singletonObj = [[self alloc] init];
    }
    return(singletonObj);
}


- (NSString *)removeNull:(NSString *)str {
    str = [NSString stringWithFormat:@"%@",str];
    if (!str) {
        return @"";
    }
    else if([str isEqualToString:@"<null>"]){
        return @"";
    }
    else if([str isEqualToString:@"(null)"]){
        return @"";
    }
    else if([str isEqualToString:@"N/A"]){
        return @"";
    }
    else if([str isEqualToString:@"n/a"]){
        return @"";
    }
    else{
        return str;
    }
}

@end
