//
//  YAGMapReportVC.m
//  Yago
//
//  Created by Macbook on 29/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

#import "YAGMapReportVC.h"
#import "Report.h"
#import "MapReport.h"
#import "YAGReportTVCell.h"

@interface YAGMapReportVC ()

@property(nonatomic,strong) MapReport *mapReport;
@property (weak, nonatomic) IBOutlet UITableView *reportTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation YAGMapReportVC

-(MapReport *)mapReport{
    if (!_mapReport) {
        _mapReport = [[MapReport alloc]init];
    }
    return _mapReport;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadReports];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadReports) forControlEvents:UIControlEventValueChanged];
    [self.reportTableView addSubview:self.refreshControl];
}

-(void)loadReports{
    [self.mapReport loadReportsWithBlock:^(bool response) {
        if (response) {
            NSLog(@"%@",self.mapReport.reports);
            [self refreshReportTable];
        }else{
            NSLog(@"ERROR ");
        }
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)clickedReportButton:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reportar" message:@"Quieres reportar lluvia?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si",nil];
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1 && buttonIndex == 1) {
        
        Report *report = [[Report alloc]init];
        report.longitude = self.longitude;
        report.latitude = self.latitude;
        
        [report addReport:report withBlock:^(bool response) {
            
            self.circ = nil;
            
            if (response) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Esta lloviendo!" message:@"Gracias por avisarnos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upps!" message:@"No pudimos registrar tu aviso" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];

            }
        }];
    }
    
}

-(void)refreshReportTable{
    [self.reportTableView reloadData];
    [self addMarkToMap:self.mapReport.reports];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mapReport.reports count];
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
        cell.leftUtilityButtons = [self leftButtons];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }
    
    @try {
        Report *report = [self.mapReport.reports objectAtIndex:indexPath.row];
        cell._description.text = [report.objectId description];
    }
    @catch (NSException *exception) {
        cell._description.text = @"Indefinido";
    }
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                icon:[UIImage imageNamed:@"clock.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                icon:[UIImage imageNamed:@"list.png"]];
    
    return leftUtilityButtons;
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
