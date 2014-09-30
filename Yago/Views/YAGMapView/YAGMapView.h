//
//  YAGMapView.h
//  Yago
//
//  Created by Macbook on 30/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface YAGMapView : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate>

@property(nonatomic,assign) double latitude;
@property(nonatomic,assign) double longitude;
@property(nonatomic,strong) IBOutlet GMSMapView *mapView;
@property(nonatomic,strong) GMSCircle *circ;

@property(nonatomic,assign) bool refreshMapCamera;

-(void)addMarkToMap:(NSMutableArray *)reports;

@end
