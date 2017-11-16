//
//  AFAPICaller.m
//  Ginger
//
//  Created by Topstech on 5/20/15.
//  Copyright (c) 2015 Topstech. All rights reserved.
//

#import "AFAPICaller.h"
#import "Global.h"

@implementation AFAPICaller

static AFAPICaller *sharedObj = NULL;


//call web service with POST method
-(void) callAPIUsingGET : (NSString *) filePath withParameters : (NSMutableDictionary *) params withEnabled : (BOOL) enableInteraction withLoader : (BOOL) showLoader inView : (UIView *) viewObj  success:(AFAPICallerSuccess)onSuccess failure:(AFAPICallerFailure)onFailure {
    
    NSString *strFullPath = [NSString stringWithFormat:@"%@%@",kbaseURLPath,filePath];
 
    strFullPath = [strFullPath stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:strFullPath] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", json);
       // [self hideRemoveLoaderFromView:viewObj :viewObj];
        if (error == nil) {
            onSuccess(json,true);
        }
        else{
            onFailure();
        }
        
    }];
    [dataTask resume];
}
@end
