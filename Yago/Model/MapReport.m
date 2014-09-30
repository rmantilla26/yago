//
//  MapReport.m
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "MapReport.h"
#import <Parse/Parse.h>
#import "Report.h"

@implementation MapReport

-(id)init{
    if (!self) {
        self = [super init];
    }
    return self;
}

-(NSMutableArray *)reports{
    if (!_reports) {
        _reports = [[NSMutableArray alloc]init];
    }
    return _reports;
}

-(void)loadReportsWithBlock:(void (^)(bool response))block{
    
    [self.reports removeAllObjects];
    
    NSDateComponents *hours = [NSDateComponents new];
    [hours setHour:TIME];
    NSDate *hoursAgo = [[NSCalendar currentCalendar] dateByAddingComponents:hours toDate:[NSDate date] options:0];
    
    PFQuery *query = [PFQuery queryWithClassName:PARSE_REPORT];
    [query whereKey:@"createdAt" greaterThan:hoursAgo];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                PFGeoPoint *location = [object objectForKey:@"location"];
                
                Report *report = [[Report alloc]init];
                report.objectId = object.objectId;
                report.latitude = location.latitude;
                report.longitude = location.longitude;
                
                [self.reports addObject:report];
                
            }
            block(true);
        } else {
            block(false);
        }
    }];
}




@end
