//
//  JIMChatVC.m
//  JustItMind
//
//  Created by Viksah on 10/28/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMChatVC.h"

@interface JIMChatVC ()<UITableViewDelegate, UITableViewDataSource>
{

}
@end

@implementation JIMChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [DefaultCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [DefaultCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard show hide notification
- (void)keyboardShow:(NSNotification*)notify
{

}

- (void)keyboardHide:(NSNotification*)notify
{

}

#pragma  mark - Tableview Delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;
}

@end
