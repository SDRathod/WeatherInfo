//
//  MapVC.h
//  WeatherApp
//
//  Created by Samir Rathod on 15/11/17.
//  Copyright (c) 2017 Samir Rathod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationModel.h"

@interface MapVC : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoader;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) LocationModel *locationShreObj;
@end
