//
//  LocationManager.m
//  Yago
//
//  Created by Raul Mantilla on 30/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "LocationManager.h"

#import <CoreLocation/CoreLocation.h>

@interface LocationManager () <CLLocationManagerDelegate>
@property (assign, nonatomic) BOOL updatedLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (copy, nonatomic) CurrentLocationSuccessBlock currentLocationSuccessBlock;
@property (copy, nonatomic) CurrentLocationFailureBlock currentLocationFailureBlock;
@end

@implementation LocationManager
- (instancetype)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    return self;
}
- (void)currentLocationSuccess:(CurrentLocationSuccessBlock)success failure:(CurrentLocationFailureBlock)failure {
    self.updatedLocation = NO;
    [self.locationManager startUpdatingLocation];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) { // iOS8+
        // Sending a message to avoid compile time error
        [[UIApplication sharedApplication] sendAction:@selector(requestWhenInUseAuthorization)
                                                   to:self.locationManager
                                                 from:self
                                             forEvent:nil];
    }
    
    /*
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
     */
    
    self.currentLocationSuccessBlock = success;
    self.currentLocationFailureBlock = failure;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (!self.updatedLocation) {
        self.updatedLocation = YES;
        [self.locationManager stopUpdatingLocation];
    } else return;
    CLLocation *lastLocation = locations.lastObject;
    double latitude = lastLocation.coordinate.latitude;
    double longitude = lastLocation.coordinate.longitude;
    if (self.currentLocationSuccessBlock) self.currentLocationSuccessBlock(latitude, longitude);
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.currentLocationFailureBlock) self.currentLocationFailureBlock(error);
    [self.locationManager stopUpdatingLocation];
}
@end