//
//  YAGReportTVCell.h
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface YAGReportTVCell : SWTableViewCell

@property(nonatomic,strong) IBOutlet UILabel *_description;
@property(nonatomic,strong) IBOutlet UIButton *_thumbnail;

@end
