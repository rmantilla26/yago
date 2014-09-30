//
//  Map.m
//  Yago
//
//  Created by Macbook on 30/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "Map.h"

@implementation Map

-(id)init{
    if (!self) {
        self = [super init];
    }
    
    
    return self;
}

-(GMSMapView *)mapView{
    if (!_mapView) {
    }
    return _mapView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"]) {
        CLLocation *location = [object myLocation];
        
        self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                             zoom:12];
        NSLog(@"Location, %@,", location);
        
        [self.mapView removeObserver:self forKeyPath:@"myLocation"];
    }
}



@end
