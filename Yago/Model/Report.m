//
//  Report.m
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "Report.h"
#import <Parse/Parse.h>

@implementation Report

-(void)addReport:(Report *)report withBlock:(void (^)(bool response))block{
    
    PFGeoPoint *location = [PFGeoPoint geoPointWithLatitude:report.latitude longitude:report.longitude];
    PFObject *query = [PFObject objectWithClassName:PARSE_REPORT];
    query[@"location"] = location;
    
    [query saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            block(true);
        }else{
            block(false);
        }
    }];
    
}


@end
 
