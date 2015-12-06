//
//  JIMMyDiscoverVC.m
//  JustItMind
//
//  Created by Viksah on 11/5/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMMyDiscoverVC.h"
#import "JIMTblSimpleCell.h"

@interface JIMMyDiscoverVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation JIMMyDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Tableview delegate and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    JIMTblSimpleCell *cell ;
    if (indexPath.row == 0)
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        [self setShadowToView:cell.viewBg];
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 190;
    }
    else
    {
    
        return 65;
    }
}

- (void)setShadowToView:(UIView*)view
{
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.8];
    [view.layer setShadowRadius:5.0];
    [view.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    view.layer.cornerRadius = 1.0f;
    view.clipsToBounds = YES;
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
