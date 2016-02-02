//
//  ChatUserListVC.m
//  JustItMind
//
//  Created by Viksah on 10/21/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "ChatUserListVC.h"
#import "TableViewCells.h"
#import "JMessage.h"
#import "JIMChatVC.h"
#import "UIImageView+AFNetworking.h"

@interface ChatUserListVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *chatList;
    
}
@end

@implementation ChatUserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [DefaultCenter addObserver:self selector:@selector(didReceiveMessage:) name:kNotificationTypeChat object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self getChatListWSCall];
}

- (void)viewWillDisappear:(BOOL)animated {
    [DefaultCenter removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - push notification
- (void)didReceiveMessage:(NSNotification *)notify {
    [self getChatListWSCall];
}

#pragma mark - Tableview datasource and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  63;
 }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chatList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatListCell"];
    JMessage *chat = chatList[indexPath.row];
    cell.lblTitle.text = chat.senderName;
    cell.lblDescription.text = chat.text;
    cell.lblTime.text = TimeStringFromTime(chat.msgDateTime);
    [cell.imgView setImageWithURL:[NSURL URLWithString:chat.senderProfilePic] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"New";
    else
        return @"Recent";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id friend = chatList[indexPath.row];
    [self performSegueWithIdentifier:@"ChatVCSegue" sender:friend];
}

#pragma mark - WS Call
- (void)getChatListWSCall  {
    id param = @{@"user_screen_id": me.userID};
    [WSCall getChatList:param block:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                id arr = JSON[@"data"];
                chatList = [NSMutableArray new];
                for(id jchat in arr)
                {
                    JMessage *chat = [JMessage new];
                    [chat setChatUser:jchat];
                    [chatList addObject:chat];
                }
                
                [self.tableView reloadData];
            }
        }
        else{
        
        }
    }];
}

- (void)sortChatList {
    NSArray *arr = chatList;
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:@"" ascending:NO];
    chatList =  [arr sortedArrayUsingDescriptors:@[des]];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ChatVCSegue"]) {
        JIMChatVC *chatVC = segue.destinationViewController;
        chatVC.friendID = ((JMessage*)sender).msgId;
    }
}
@end
