//
//  UAAPIMaster.h
//  UrbanApp
//
//  Created by Topstech on 5/20/15.
//  Copyright (c) 2015 Topstech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFAPICaller.h"

typedef void(^UAAPIMasterSuccess)(id returnData);
typedef void(^UAAPIMasterFailure)();


@interface UAAPIMaster : AFAPICaller {
}

+(UAAPIMaster *)sharedMaster;

//basic  API
- (void) getWeatherApiCall : (NSString *) strAddress withEnabled : (BOOL) enableInteractionwithLoader : (BOOL) showLoader inView : (UIView *) viewObj : (UAAPIMasterSuccess) onSuccess;
@end
