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
}

-(void)loadReports{
    [self.mapReport loadReportsWithBlock:^(bool response) {
        if (response) {
            NSLog(@"%@",self.mapReport.reports);
            [self refreshReportTable];
        }else{
            NSLog(@"ERROR ");
        }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"YAGReportTVCellID";
    YAGReportTVCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YAGReportTVCell" owner:self options:nil];
        cell = (YAGReportTVCell *) [nib objectAtIndex:0];
    }
    
    Report *report = [self.mapReport.reports objectAtIndex:indexPath.row];
    cell._description.text = [report.objectId description];

    return cell;
}
 

@end
