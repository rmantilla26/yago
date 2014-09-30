//
//  Device.h
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Device : NSObject<CLLocationManagerDelegate>



@property (nonatomic, retain) CLLocationManager *locationManager;

-(void)getCurrentLocation;

@end
