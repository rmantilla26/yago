//
//  LocationManager.h
//  Yago
//
//  Created by Raul Mantilla on 30/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;
typedef void (^CurrentLocationSuccessBlock)(double latitude, double longitude);
typedef void (^CurrentLocationFailureBlock)(NSError *error);

@interface LocationManager : NSObject

- (void)currentLocationSuccess:(CurrentLocationSuccessBlock)success failure:(CurrentLocationFailureBlock)failure;

@end
