//
//  YAGMapReportVC.m
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "YAGMapReportVC.h"
#import "YAGReportTVCell.h"
#import "YAGReportAddVC.h"
#import "Report.h"
#import "Event.h"

@interface YAGMapReportVC ()

@property(nonatomic,strong) Event *event;
@property (weak, nonatomic) IBOutlet UITableView *reportTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation YAGMapReportVC


-(Event *)event{
    if (!_event) {
        _event = [[Event alloc]init];
    }
    return _event;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self loadReports];
    
    [self loadEvent];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadReports) forControlEvents:UIControlEventValueChanged];
    [self.reportTableView addSubview:self.refreshControl];
}

-(void)loadEvent{
 
    [self.event loadEvent:@"upgqY1CnZx" WithBlock:^(bool response) {
        if (response) {
            NSLog(@"%@",self.event);
            [self loadReports];
        }else{
            NSLog(@"ERROR ");
        }
    }];
}

-(void)loadReports{
    [self.event loadReportsWithBlock:^(bool response) {
        if (response) {
            NSLog(@"%@",self.event.reports);
            [self refreshReportTable];
        }else{
            NSLog(@"ERROR ");
        }
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)clickedReportButton:(UIButton *)sender {
    
    YAGReportAddVC * reportAddVC = [[YAGReportAddVC alloc]initWithNibName:@"YAGReportAddVC" bundle:nil];
    
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    
    UIImage *copiedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self  presentViewController:reportAddVC animated:YES completion:^{
        [reportAddVC.view setBackgroundColor:[UIColor colorWithPatternImage:copiedImage]];
    }];
    

    
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reportar" message:@"Quieres reportar lluvia?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si",nil];
    alert.tag = 1;
    [alert show];
     */
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1 && buttonIndex == 1) {
        
        Report *report = [[Report alloc]init];
        report.longitude = self.longitude;
        report.latitude = self.latitude;
        
        [self.event addReport:report withBlock:^(bool response) {
            if (response) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Esta lloviendo!" message:@"Gracias por avisarnos" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upps!" message:@"No pudimos registrar tu aviso" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    
}

-(void)refreshReportTable{
    [self.reportTableView reloadData];
    [self addMarkToMap:self.event.reports];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.event.reports count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return REPORT_TABLE_TITLE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"YAGReportTVCellID";
    YAGReportTVCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YAGReportTVCell" owner:self options:nil];
        cell = (YAGReportTVCell *) [nib objectAtIndex:0];
        cell.leftUtilityButtons = [cell leftButtons];
        cell.rightUtilityButtons = [cell rightButtons];
        cell.delegate = self;
    }
    
    @try {
        Report *report = [self.event.reports objectAtIndex:indexPath.row];
        cell._description.text = [report.objectId description];
    }
    @catch (NSException *exception) {
        cell._description.text = @"Indefinido";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Report *report = [self.event.reports objectAtIndex:indexPath.row];
    [self addMarkWithReport:report removeOtherMark:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self addMarkToMap:self.event.reports];
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"More button was pressed");
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"More more more" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [self.reportTableView indexPathForCell:cell];
            
            [self.reportTableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}


 

@end
