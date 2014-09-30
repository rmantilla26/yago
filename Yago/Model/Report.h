//
//  Report.h
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Report : NSObject

@property(nonatomic,strong)  NSString *objectId;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@property(nonatomic,strong)  NSDate *createAt;

-(void)addReport:(Report *)report withBlock:(void (^)(bool response))block;

@end
 
