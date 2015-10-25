//
//  ChatUserListVC.m
//  JustItMind
//
//  Created by Viksah on 10/21/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "ChatUserListVC.h"

@interface ChatUserListVC ()<UITableViewDataSource, UITableViewDelegate>
{

}
@end

@implementation ChatUserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview datasource and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  63;
 }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatListCell"];
    return cell;
}

@end
