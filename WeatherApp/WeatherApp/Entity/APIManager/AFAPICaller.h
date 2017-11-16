//
//  AFAPICaller.h
//  Ginger
//
//  Created by Topstech on 5/20/15.
//  Copyright (c) 2015 Topstech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AFAPICallerSuccess)(id responseData, BOOL success);
typedef void(^AFAPICallerFailure)();
//typedef void(^AFAPICallreturnString)(NSString *strReturn);

@interface AFAPICaller : NSObject

-(UIView *) addShowLoaderInView : (UIView *) viewObj : (BOOL) boolShow : (BOOL) enableInteraction;
-(void) hideRemoveLoaderFromView : (UIView *) removableView : (UIView *) mainView;

//call web service with POST method
-(void) callAPIUsingGET : (NSString *) filePath withParameters : (NSMutableDictionary *) params withEnabled : (BOOL) enableInteraction withLoader : (BOOL) showLoader inView : (UIView *) viewObj  success:(AFAPICallerSuccess)onSuccess failure:(AFAPICallerFailure)onFailure;

//- (void)callGETApi : (NSString *) apiName withParm : (NSMutableDictionary *) params success : (AFAPICallerSuccess) onSuccess failure : (AFAPICallerFailure)onFailure;



@end
