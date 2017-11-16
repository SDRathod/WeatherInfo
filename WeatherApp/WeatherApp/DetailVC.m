//
//  DetailVC.m
//  WeatherApp
//
//  Created by Samir Rathod on 15/11/17.
//  Copyright (c) 2017 Samir Rathod. All rights reserved.
//

#import "DetailVC.h"
#import "UAAPIMaster.h"
#import "Singleton.h"

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityViewobj.hidden = true;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.activityViewobj.hidden = false;
    
    [[UAAPIMaster sharedMaster] getWeatherApiCall:[NSString stringWithFormat:@"%@,%@",self.locationShreObj.strCity,self.locationShreObj.strCountry] withEnabled:true :true inView:self.view :^(id returnData) {
        NSLog(@"%@",returnData);
        
        @try {
            NSDictionary *dictMain = (NSDictionary *)returnData;
            NSDictionary *dictQuery = [dictMain objectForKey:@"query"];
            NSDictionary *dictResult = [dictQuery objectForKey:@"results"];
            NSDictionary *dictChannel = [dictResult objectForKey:@"channel"];
            NSDictionary *dictastronomy = [dictChannel objectForKey:@"astronomy"]; // Sunrise and Sunset
            NSDictionary *dictItem = [dictChannel objectForKey:@"item"];
            
            
            NSString *strTitle = [[Singleton sharedSingleton] removeNull:[dictItem objectForKey:@"title"]];
            NSString *dateTime = [[Singleton sharedSingleton] removeNull:[dictItem objectForKey:@"pubDate"]];
            
            
            NSDictionary *dictCondition = [dictItem objectForKey:@"condition"];
            
            NSString *strText = [[Singleton sharedSingleton] removeNull:[dictCondition objectForKey:@"text"]];
            NSString *strTemp = [[Singleton sharedSingleton] removeNull:[dictCondition objectForKey:@"temp"]];
            if ([strTemp isEqualToString:@""]) {
                strTemp = @"0";
            }
            float fahrenheit = [strTemp floatValue];
            float Celsius = 5.0/9.0 * (fahrenheit-32);
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // Background work
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Update UI
                    self.lblTitle.text = strTitle;
                    self.lblDate.text = dateTime;
                    self.lblTemp.text = [NSString stringWithFormat:@"Temperature in Celsius : %.02f",Celsius];
                    self.lblWeather.text = [NSString stringWithFormat:@"Weather is %@ now",strText];
                    self.lblSunrise.text = [NSString stringWithFormat:@"Sunrise time : %@",[dictastronomy objectForKey:@"sunrise"]];
                    self.lblSunset.text = [NSString stringWithFormat:@"Sunset time : %@",[dictastronomy objectForKey:@"sunset"]];
                    self.activityViewobj.hidden = true;
                });
            });
        }
        @catch (NSException *exception) {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"Weater app" message:@"Something went wrong!!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alt show];
            self.activityViewobj.hidden = true;
        }
        @finally {
           
        }
    }];
}

- (void)setLocationShareObje : (LocationModel *)shrObj {
    self.locationShreObj = shrObj;
}
@end
