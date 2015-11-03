//
//  JIMResidentVC.m
//  JustItMind
//
//  Created by Viksah on 11/4/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMResidentVC.h"
#import "JIMTblSimpleCell.h"

@interface JIMResidentVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *arrSectionTitile;
    NSArray *arrResidents;
}
@end

@implementation JIMResidentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    arrSectionTitile = @[@"A",@"B",@"E",@"V"];
    arrResidents = @[@[@"Aniee Laaa",@"Andi Mare"], @[@"Boston Bos"], @[@"Elise nene",@"Enjelia Jon", @"Ethupia"], @[@"Viliams Smith", @"Venila Park"]];
}

#pragma mark - Tableview datasource and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  55;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrSectionTitile.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrResidents[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JIMTblSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"residentCell"];
    
    cell.lblName.text = arrResidents[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JIMTblSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    cell.lblName.text = arrSectionTitile[section];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
