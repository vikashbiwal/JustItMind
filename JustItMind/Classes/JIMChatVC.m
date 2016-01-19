//
//  JIMChatVC.m
//  JustItMind
//
//  Created by Viksah on 10/28/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMChatVC.h"
#import "JIMChatCell.h"
#import "JMessage.h"

@interface JIMChatVC ()<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet NSLayoutConstraint *messageViewBottomSpace;
    IBOutlet UITextView *txtView;
    NSMutableArray *arrMessages;
    
}
@end

@implementation JIMChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [DefaultCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [DefaultCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    arrMessages = [NSMutableArray new];
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
    JMessage *msg = arrMessages[indexPath.row];
    if([msg.senderID isEqualToString:me.userID]) {
        cellIndentifier = @"senderCell";
    }
    else{
        cellIndentifier = @"receiverCell";
    }
    JIMChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    cell.lblMessage.text = msg.text;
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

#pragma mark - IBActions
- (IBAction)messageSendBtnClicked:(id)sender
{
    if(txtView.text.length == 0) return;
    
    id param = @{@"to":_friend.userID, @"from":me.userID,@"msg": txtView.text};
    
    [WSCall sendChatMessage:param block:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                JMessage *msg = [JMessage new];
                msg.text = txtView.text;
                msg.senderID = me.userID;
                msg.senderName = me.firstName;
                msg.senderProfilePic = me.profileImageUrl;
                msg.strTime = @"";
                [arrMessages addObject:msg];
                [self.tableView reloadData];
                txtView.text = @"";
            }
        }
    }];
}
@end
