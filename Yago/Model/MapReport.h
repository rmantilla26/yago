//
//  MapReport.h
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Map;

@interface MapReport : NSObject

@property(nonatomic,strong) NSMutableArray *reports;
@property(nonatomic,strong) Map *map;

-(void)loadReportsWithBlock:(void (^)(bool response))block;

@end
