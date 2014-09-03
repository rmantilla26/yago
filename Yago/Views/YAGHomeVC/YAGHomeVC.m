//
//  YAGHomeVC.m
//  Yago
//
//  Created by Macbook on 3/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "YAGHomeVC.h"
#import "YAGMapReportVC.h"

@interface YAGHomeVC ()

@end

@implementation YAGHomeVC

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
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy =
        kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
    }
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goToMapReport:(id)sender {
    
    YAGMapReportVC *vc = [[YAGMapReportVC alloc]initWithNibName:@"YAGMapReportVC" bundle:nil];
    [self.navigationController  presentViewController:vc animated:YES completion:nil];
}

@end
