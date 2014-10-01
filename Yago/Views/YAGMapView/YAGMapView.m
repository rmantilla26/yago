//
//  YAGMapView.m
//  Yago
//
//  Created by Macbook on 30/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "YAGMapView.h"
#import "Report.h"
#import "LocationManager.h"

@interface YAGMapView ()

@property (strong, nonatomic) LocationManager *locationManager;

@end

@implementation YAGMapView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager  = [[LocationManager alloc]init];
    [self.locationManager currentLocationSuccess:^(double latitude, double longitude) {
    
        [self.mapView addObserver:self forKeyPath:@"myLocation" options:0 context:nil];
        self.mapView.delegate = self;
        self.refreshMapCamera = true;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mapView.myLocationEnabled = YES;
        });
        
    } failure:^(NSError *error) {
    
        //FALSE
        
    }];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"]) {
        CLLocation *location = [object myLocation];
        
        self.latitude = location.coordinate.latitude;
        self.longitude = location.coordinate.longitude;
        
        if (self.latitude == 0) {
            self.latitude = DEFAULT_LATITUDE;
            self.longitude = DEFAULT_LONGITUDE;
        }
        
        if (self.refreshMapCamera) {
            self.refreshMapCamera = false;
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.latitude
                                                                    longitude:self.longitude
                                                                         zoom:MAP_ZOOM];
            self.mapView.camera = camera;
        }
        NSLog(@"Location, %@,", location);
    }
}

-(void)addMarkToMap:(NSMutableArray *)reports{
    
    [self.mapView clear];
    
    for (Report *report in reports) {
            CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(report.latitude, report.longitude);
            
            self.circ = [GMSCircle circleWithPosition:circleCenter radius:500];
            
            self.circ.fillColor = [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:0.3];
            self.circ.strokeColor = [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1];
            self.circ.strokeWidth = 1;
            self.circ.map = self.mapView;
    }
}

@end
