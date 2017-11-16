//
//  UAAPIMaster.m
//  UrbanApp
//
//  Created by Topstech on 5/20/15.
//  Copyright (c) 2015 Topstech. All rights reserved.
//

#import "UAAPIMaster.h"

@implementation UAAPIMaster


static UAAPIMaster *sharedObj = NULL;

-(id)init{
    self = [super init];
    if (self){
        // do something
    }
    return self;
}

+(UAAPIMaster *)sharedMaster {
    @synchronized(self) {
        if (sharedObj == NULL)
            sharedObj = [[self alloc] init];
    }
    return(sharedObj);
}

#pragma mark -
#pragma mark  Basic API

- (void) getWeatherApiCall : (NSString *) strAddress withEnabled : (BOOL) enableInteractionwithLoader : (BOOL) showLoader inView : (UIView *) viewObj : (UAAPIMasterSuccess) onSuccess {
    
    NSString *strQuery = [NSString stringWithFormat:@"select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"%@\")&format=json",strAddress];
    
    [self callAPIUsingGET:strQuery withParameters:nil withEnabled:true withLoader:showLoader inView:viewObj success:^(id responseData, BOOL success) {
        if (success) {
            onSuccess(responseData);
        }
    } failure:^{
        
    }];
}


#pragma mark -
#pragma mark  Settings API Call




#pragma mark -
#pragma mark  Notification API Call


@end
