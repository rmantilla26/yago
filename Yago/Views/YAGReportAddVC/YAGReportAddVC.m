//
//  YAGReportAddVC.m
//  Yago
//
//  Created by Macbook on 6/10/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "YAGReportAddVC.h"

@interface YAGReportAddVC ()

@end

@implementation YAGReportAddVC

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
}

-(IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:NO completion:^{
        //code
    }];
}



@end
