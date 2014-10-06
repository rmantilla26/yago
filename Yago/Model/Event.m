//
//  Event.m
//  Yago
//
//  Created by Macbook on 2/10/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "Event.h"
#import "Report.h"
#import "User.h"
#import <Parse/Parse.h>

@interface Event ()
@property(nonatomic,strong)  PFRelation *reportsRelation;
@property(nonatomic,strong)  PFRelation *participantsRelation;
@end

@implementation Event


-(NSMutableArray *)reports{
    if (!_reports) {
        _reports = [[NSMutableArray alloc]init];
    }
    return _reports;
}

-(NSMutableArray *)participants{
    if (!_participants) {
        _participants = [[NSMutableArray alloc]init];
    }
    return _participants;
}



-(void)loadEvent:(NSString *)objectId WithReportsAndParticipantsWithBlock:(void (^)(bool response))block{
    
    PFQuery *query = [PFQuery queryWithClassName:PARSE_REPORT];
    [query whereKey:@"objectId" equalTo:objectId];
    
    // Retrieve the most recent ones
    [query orderByDescending:@"createdAt"];
    
    // Only retrieve the last ten
    query.limit = 1000;
    
    // Include the reports data
    [query includeKey:PARSE_EVENT];
    // Include the participants data
    //[event includeKey:PARSE_PARTICIPANTS];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        // Comments now contains the last ten comments, and the "post" field
        // has been populated. For example:
        for (PFObject *comment in comments) {
            // This does not require a network access.
            PFObject *post = comment[@"reports"];
            NSLog(@"retrieved related post: %@", post);
        }
    }];
    /*
    [event getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        if (!error) {
            self.name = [object objectForKey:@"name"];
            self.information = [object objectForKey:@"information"];
            self.reportsRelation = [object relationForKey:@"reports"];
            self.participantsRelation = [object relationForKey:@"participants"];
            
            
            block(true);
        } else {
            block(false);
        }
    }];
     */
}


-(void)loadEvent:(NSString *)objectId WithBlock:(void (^)(bool response))block{
    
    PFQuery *query = [PFQuery queryWithClassName:PARSE_EVENT];
    [query whereKey:@"objectId" equalTo:objectId];
    
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        if (!error) {
            self.name = [object objectForKey:@"name"];
            self.information = [object objectForKey:@"information"];
            self.reportsRelation = [object relationForKey:@"reports"];
            self.participantsRelation = [object relationForKey:@"participants"];
            block(true);
        } else {
            block(false);
        }
    }];
}


-(void)loadParticipantsWithBlock:(void (^)(bool response))block{
    
    [self.participants removeAllObjects];
    
    PFQuery *query = [self.participantsRelation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                User *user = [[User alloc]init];
                user.objectId = object.objectId;
                user.username = [object objectForKey:@"username"];
                [self.participants addObject:user];
            }
            block(true);
        } else {
            block(false);
        }
    }];
}


-(void)loadReportsWithBlock:(void (^)(bool response))block{
    
    [self.reports removeAllObjects];
    
    PFQuery *query = [self.reportsRelation query];
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
