//
//  DetailVC.h
//  WeatherApp
//
//  Created by Samir Rathod on 15/11/17.
//  Copyright (c) 2017 Samir Rathod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"

@interface DetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webviewObj;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblWeather;
@property (weak, nonatomic) IBOutlet UILabel *lblTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblSunrise;
@property (weak, nonatomic) IBOutlet UILabel *lblSunset;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityViewobj;


@property(nonatomic, strong) LocationModel *locationShreObj;

- (void)setLocationShareObje : (LocationModel *)shrObj;



@end
