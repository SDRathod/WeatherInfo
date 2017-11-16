//
//  MapVC.m
//  WeatherApp
//
//  Created by Samir Rathod on 15/11/17.
//  Copyright (c) 2017 Samir Rathod. All rights reserved.
//

#import "MapVC.h"
#import "DetailVC.h"
#import "Reachability.h"
#import "Global.h"

@interface MapVC () <UIGestureRecognizerDelegate>

typedef void(^addressCompletion)(NSDictionary *);

@end

@implementation MapVC

@synthesize mapView,activityLoader;

#pragma mark -
#pragma mark  View Lifecycle event

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    // Use one or the other, not both. Depending on what you put in info.plist
    //[self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];

    [self.locationManager startUpdatingLocation];
    
    mapView.showsUserLocation = YES;
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    
    self.locationShreObj = [[LocationModel alloc] init];
    mapView.delegate = self;
    
    UITapGestureRecognizer *tapg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    tapg.numberOfTapsRequired = 2;
    tapg.delegate = self;
    [self.mapView addGestureRecognizer:tapg];
    self.activityLoader.hidden = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationItem.title = @"Find weather";
    if (![self connected]) {
        // Not connected
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:kAppName message:@"Please Check your internet connection" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alt show];
        
    } else {
        // Connected. Do some Internet stuff
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark  MKMapView Delegate methods


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
   
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    [self.mapView addAnnotation:point];
    self.locationShreObj.latitude = userLocation.coordinate.latitude;
    self.locationShreObj.longitude = userLocation.coordinate.longitude;
    CLLocation* eventLocation = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    
    __block LocationModel *locTemp = self.locationShreObj;
    
    
    
    [self getAddressFromLocation:eventLocation complationBlock:^(NSDictionary * address) {
        if(address) {
            NSString *strAddress = @"";
            
            NSArray *arrAddress = (NSArray *)[address objectForKey:@"FormattedAddressLines"];
            for (int i=0; i < arrAddress.count; i++) {
                if (i==address.count-1)
                    strAddress  =  [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",[arrAddress objectAtIndex:i]]];
                else
                    strAddress  =  [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arrAddress objectAtIndex:i]]];
            }
            locTemp.strLocationName = strAddress;
            point.subtitle = strAddress;
        }
        //[self showLoader:true];
    }];

}

- (void)showLoader : (BOOL) value {
    self.activityLoader.hidden = value;
    self.view.userInteractionEnabled = value;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    static NSString *s = @"Annotation";
    MKAnnotationView *pin = [self.mapView dequeueReusableAnnotationViewWithIdentifier:s];
    if (!pin) {
        pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:s];
        pin.canShowCallout = YES;
        //pin.image = [UIImage imageNamed:@"Pin.png"];
        
        pin.calloutOffset = CGPointMake(0, 0);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:self
                   action:@selector(viewDetails) forControlEvents:UIControlEventTouchUpInside];
        pin.rightCalloutAccessoryView = button;
        
    }
    return pin;
}

#pragma mark -
#pragma mark  Common functions

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

-(void)getAddressFromLocation:(CLLocation *)location complationBlock:(addressCompletion)completionBlock
{
    __block CLPlacemark* placemark;
    __block NSString *address = nil;
    
    [self showLoader:false];
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             placemark = [placemarks lastObject];
             address = [NSString stringWithFormat:@"%@, %@ %@", placemark.name, placemark.postalCode, placemark.locality];
             NSLog(@"addressDictionary = %@", placemark.addressDictionary);
             self.locationShreObj.strCity = [placemark.addressDictionary objectForKey:@"City"];
             self.locationShreObj.strCountry = [placemark.addressDictionary objectForKey:@"Country"];
             
             completionBlock(placemark.addressDictionary);
             /*
              Address dictionary like :
              
              addressDictionary = {
              City = Ahmedabad;
              Country = India;
              CountryCode = IN;
              FormattedAddressLines =     (
              "Ellis Bridge",
              Ahmedabad,
              "Gujarat 380014",
              India
              );
              Name = 380014;
              State = Gujarat;
              SubAdministrativeArea = Ahmedabad;
              SubLocality = "Ellis Bridge";
              ZIP = 380014;
              }
              
              */
         }
         [self showLoader:true];
     }];
}

- (void)viewDetails {
    DetailVC *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    [controller setLocationShareObje:self.locationShreObj];
    [self.navigationController pushViewController:controller animated:YES];

}

#pragma mark -
#pragma mark  UIGestureRecognizer Delegate and handling evnt

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = touchMapCoordinate;
    point.title = @"Where am I?";
    [self.mapView addAnnotation:point];
    
    
    self.locationShreObj.latitude = touchMapCoordinate.latitude;
    self.locationShreObj.longitude = touchMapCoordinate.longitude;
    
    CLLocation* eventLocation = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.latitude];
    
    __block LocationModel *locTemp = self.locationShreObj;
    
    [self getAddressFromLocation:eventLocation complationBlock:^(NSDictionary * address) {
        if(address) {
            NSString *strAddress = @"";
            
            NSArray *arrAddress = (NSArray *)[address objectForKey:@"FormattedAddressLines"];
            for (int i=0; i < arrAddress.count; i++) {
                if (i==address.count-1)
                    strAddress  =  [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",[arrAddress objectAtIndex:i]]];
                else
                    strAddress  =  [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arrAddress objectAtIndex:i]]];
            }
            locTemp.strLocationName = strAddress;
            point.subtitle = strAddress;
        }
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
