//
//  JIMChatVC.m
//  JustItMind
//
//  Created by Viksah on 10/28/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMChatVC.h"
#import "JIMChatCell.h"

@interface JIMChatVC ()<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet NSLayoutConstraint *messageViewBottomSpace;
    NSArray *arrMessages;
}
@end

@implementation JIMChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [DefaultCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [DefaultCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    arrMessages = @[@"hey man what's up?", @"Just wondering if you had those notes from according the other day", @"This new game our team definitaly win, and we will qualify for Olampyc",@"Hi",@"yes",@"Good Morning",@"hi, are you goint to participate in game"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions



#pragma mark - Keyboard show hide notification
- (void)keyboardShow:(NSNotification*)notify
{
    CGRect rect = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    messageViewBottomSpace.constant = rect.size.height;
}

- (void)keyboardHide:(NSNotification*)notify
{
    messageViewBottomSpace.constant = 10;
}

#pragma  mark - Tableview Delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arrMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier;
    if(indexPath.row % 2 == 0)
        cellIndentifier = @"receiverCell";
    else
        cellIndentifier = @"senderCell";
    JIMChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.lblMessage.text = arrMessages[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}
@end
