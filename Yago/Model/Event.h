//
//  Event.h
//  Yago
//
//  Created by Macbook on 2/10/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Event : NSObject

@property(nonatomic,strong)  NSString *objectId;
@property(nonatomic,strong)  NSString *name;
@property(nonatomic,strong)  NSString *information;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@property(nonatomic,strong)  NSDate *createAt;

@property(nonatomic,strong) NSMutableArray *reports;
@property(nonatomic,strong) NSMutableArray *participants;

-(void)loadEvent:(NSString *)objectId WithBlock:(void (^)(bool response))block;
-(void)loadReportsWithBlock:(void (^)(bool response))block;
-(void)loadParticipantsWithBlock:(void (^)(bool response))block;
-(void)loadEvent:(NSString *)objectId WithReportsAndParticipantsWithBlock:(void (^)(bool response))block;

@end
