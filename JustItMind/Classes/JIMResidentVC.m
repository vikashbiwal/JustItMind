//
//  JIMResidentVC.m
//  JustItMind
//
//  Created by Viksah on 11/4/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMResidentVC.h"
#import "JIMTblSimpleCell.h"
#import "JIMProfileVC.h"

@interface JIMResidentVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *arrSectionTitile;
    NSMutableDictionary *sections;
    NSMutableArray *arrResidents;
}
@end

@implementation JIMResidentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRAUsers];
    
}

#pragma mark - Tableview datasource and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  55;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections allKeys].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sections objectForKey:[sections allKeys][section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JIMTblSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"residentCell"];
    User *ra =  [sections objectForKey:[sections allKeys][indexPath.section]][indexPath.row];
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@", ra.firstName, ra.lastName];
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JIMTblSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    cell.lblName.text = [[sections allKeys][section] uppercaseString];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user =  [sections objectForKey:[sections allKeys][indexPath.section]][indexPath.row];
    JIMProfileVC *profileVC = [newsFeedStBoard instantiateViewControllerWithIdentifier:@"SBID_ProfileVC"];
    profileVC.strUserID = user.userID;
    profileVC.fromPush = YES;
    [self.navigationController pushViewController:profileVC animated:YES];
   
}
#pragma mark : WS methods

- (void)getRAUsers {
//    id param = @{@"user_type":@"RA"};
    id param = @{@"user_type":@"ST"};
    [WSCall getUsers:param block:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                NSArray *arr = JSON[@"data"];
                arrResidents = [NSMutableArray new];
                for(id juser in arr) {
                    User *user = [User new];
                    [user setInfo:juser];
                    [arrResidents addObject:user];
                }
                [self setAlphabeticSection];
            }
        }
        else
        {
        
        }
    }];
}

- (void)setAlphabeticSection {
    sections = [NSMutableDictionary new];
  
    NSSortDescriptor *alphaNumSD = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES comparator:^(NSString *string1, NSString *string2) {
        return [string1 compare:string2 options:NSNumericSearch];
    }];
    NSArray *sortedArray = [arrResidents sortedArrayUsingDescriptors:@[alphaNumSD]];

    for (User *user in sortedArray) {
        if (user.firstName.length > 0) {
            NSString *c = [user.firstName substringToIndex:1];
            if(![sections objectForKey:c])
            {
                [sections setObject:[NSMutableArray new] forKey:c];
            }
            NSMutableArray *section = [sections objectForKey:c];
            [section addObject:user];
        }
    }
    [self.tableView reloadData];
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
