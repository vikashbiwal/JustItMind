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
#import "UIImageView+AFNetworking.h"

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
    parentlblTitle.text = _friendName;
    arrMessages = [NSMutableArray new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [DefaultCenter addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [DefaultCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [DefaultCenter addObserver:self selector:@selector(didReceiveMessage:) name:kNotificationTypeChat object:nil];
    [self getConversationBetweenMeAndFriend];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [DefaultCenter removeObserver:self];
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

#pragma mark - push notification 
- (void)didReceiveMessage:(NSNotification *)notify {
    id message = notify.userInfo[@"message"];
    if([message[@"TargetId"] isEqualToString:_friendID]) {
        JMessage *msg = [JMessage new];
        msg.text = message[@"message"];
        msg.senderID = message[@"TargetId"];
        msg.senderName = message[@"firstname"];
        msg.senderProfilePic = [NSString stringWithFormat:@"%@/%@",kImageBasePath, message[@"profile_pic_url"]];
        [arrMessages addObject:msg];
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:[self.tableView numberOfRowsInSection:0] inSection:0] ;
        [self.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    }
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
        cellIndentifier = @"myMsgCell";

    }
    else{
        cellIndentifier = @"friendMsgCell";
    }
    JIMChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell.profilePic setImageWithURL:[NSURL URLWithString:msg.senderProfilePic] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
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
    [self sendMessage];
}

#pragma mark - WS 

- (void)sendMessage {
    
    if(txtView.text.length == 0) return;
    id param = @{@"to":_friendID, @"from":me.userID,@"msg": txtView.text};
    
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
                NSIndexPath *indexpath = [NSIndexPath indexPathForItem:[self.tableView numberOfRowsInSection:0] inSection:0] ;
                [self.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                [self scrollToBottom];
                txtView.text = @"";
            }
        }
    }];

}

- (void)getConversationBetweenMeAndFriend {
    id param = @{@"to": _friendID, @"from": me.userID};
    [WSCall getChatConversationBetweenTwoUser:param block:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                NSArray *arr = JSON[@"data"];
                arrMessages = [NSMutableArray new];
                for(id msg in arr) {
                    JMessage *message = [[JMessage alloc]init];
                    [message setMessage:msg];
                    [arrMessages addObject:message];
                }
                [self.tableView reloadData];
                [self scrollToBottom];
            }
        
        }
    }];
}

- (void)scrollToBottom {
    if (arrMessages.count > 0) {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:arrMessages.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
@end
