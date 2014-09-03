//
//  YAGHomeVC.h
//  Yago
//
//  Created by Macbook on 3/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface YAGHomeVC : UIViewController<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

@end
