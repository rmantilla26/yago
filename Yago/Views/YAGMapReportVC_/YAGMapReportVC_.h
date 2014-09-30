//
//  YAGMapReportVC.h
//  Yago
//
//  Created by Macbook on 3/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface YAGMapReportVC : UIViewController<CLLocationManagerDelegate,UIAlertViewDelegate,GMSMapViewDelegate>

@property(nonatomic,assign) double latitude;
@property(nonatomic,assign) double longitude;
@property(nonatomic,strong) IBOutlet  GMSMapView *mapView_;

@property (nonatomic, retain) CLLocationManager *locationManager;

@end
