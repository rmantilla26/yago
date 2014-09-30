//
//  Device.m
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "Device.h"

@implementation Device


-(void)getCurrentLocation{
    
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    [self.locationManager startUpdatingLocation];
    
    CLLocation *curPos = self.locationManager.location;
    self.latitude = curPos.coordinate.latitude;
    self.longitude = curPos.coordinate.longitude;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
    
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
}



@end
