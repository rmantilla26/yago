//
//  YAGMapReportVC.m
//  Yago
//
//  Created by Macbook on 3/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "YAGMapReportVC.h"


@interface YAGMapReportVC ()

@end

@implementation YAGMapReportVC{
    GMSMapView *mapView_;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadMapData:nil];
}

-(void)getCurrentLocation{
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy =
        kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
    }
    [self.locationManager startUpdatingLocation];
    
    CLLocation *curPos = self.locationManager.location;
    self.latitude = curPos.coordinate.latitude;
    self.longitude = curPos.coordinate.longitude;
}

-(IBAction)PressedRainingButton:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reportar" message:@"Quieres reportar lluvia?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si",nil];
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1 && buttonIndex == 1) {
        
        [self getCurrentLocation];
        
        CLLocation *curPos = self.locationManager.location;
        
        PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:curPos.coordinate.latitude longitude:curPos.coordinate.longitude];
        
        PFObject *rainObject = [PFObject objectWithClassName:@"Raining"];
        rainObject[@"location"] = location;
        [rainObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Esta lloviendo!" message:@"Gracias por avisarnos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [self loadMapData:nil];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upps!" message:@"No pudimos registrar tu aviso" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    
}

-(IBAction)loadMapData:(id)sender{
    
    [self getCurrentLocation];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.latitude
                                                            longitude:self.longitude
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.mapGoogleView_ = mapView_;
    
    [mapView_ clear];
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(11.00312,-74.82309);
    marker.title = @"Llueve";
    marker.snippet = @"Barranquilla";
    marker.map = mapView_;
    
    
    NSDate *now = [NSDate date];
    NSDateComponents *hours = [NSDateComponents new];
    [hours setHour:-1];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *hoursAgo = [cal dateByAddingComponents:hours toDate:now options:0];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Raining"];
    [query whereKey:@"createdAt" greaterThan:hoursAgo];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                PFGeoPoint *location = [object objectForKey:@"location"];
                CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(location.latitude, location.longitude);
                
                GMSCircle *circ = [GMSCircle circleWithPosition:circleCenter radius:500];
                
                circ.fillColor = [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:0.3];
                circ.strokeColor = [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1];
                circ.strokeWidth = 1;
                circ.map = mapView_;
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upps!" message:@"No pudimos realizar esta operación" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
