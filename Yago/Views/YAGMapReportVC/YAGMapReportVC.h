//
//  YAGMapReportVC.h
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAGMapView.h"
#import "SWTableViewCell.h"

@interface YAGMapReportVC : YAGMapView<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,SWTableViewCellDelegate>

@end