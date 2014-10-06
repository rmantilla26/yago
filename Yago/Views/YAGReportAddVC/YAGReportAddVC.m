//
//  YAGReportAddVC.m
//  Yago
//
//  Created by Macbook on 6/10/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "YAGReportAddVC.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>


@interface YAGReportAddVC ()

@property (weak, nonatomic) IBOutlet UITextView *insight;

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
    self.insight.delegate = self;
    self.insight.text = TEXTVIEW_PLACEHOLDER;
    self.insight.textColor = [UIColor lightGrayColor];
    self.zoom = 15;
    self.insight.layer.borderWidth = 0.3f;
    self.insight.layer.cornerRadius = 5.0f;
    self.insight.layer.borderColor = [[UIColor grayColor] CGColor];
    //[self.insight becomeFirstResponder];
}

-(IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:NO completion:^{
        //code
    }];
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:TEXTVIEW_PLACEHOLDER]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = TEXTVIEW_PLACEHOLDER;
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}



@end
