//
//  JIMContainerVC.m
//  JustItMind
//
//  Created by Viksah on 9/29/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMContainerVC.h"
#import "JMessage.h"
#import "TableViewCells.h"

#define bottomMenuValue -140
#define leftMenuValue -200
#define rightMenuValue -200
//#define newsFeedStBoard [UIStoryboard storyboardWithName:@"NewsFeed" bundle:nil]
@interface JIMContainerVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableViewChat;
    IBOutlet UIImageView *notificatoinIcn;
    IBOutlet UIImageView *messageIcn;
    IBOutlet UIImageView *bottomMenuBgImgV;
    __weak IBOutlet UIView  *tabContainer;
    __weak IBOutlet UIView *bottomMenu;
    __weak IBOutlet UIView *leftMenuView;
    __weak IBOutlet UIView *leftMenuBtnView;
    __weak IBOutlet UIView *rightMenuView;
    __weak IBOutlet UIView *rightMenuBtnView;
    
    __weak IBOutlet NSLayoutConstraint *bottomMenuBottomSapce;
    __weak IBOutlet NSLayoutConstraint *leftMenuLeadingSpace;
    __weak IBOutlet NSLayoutConstraint *rightMenuTraillingSpace;
    
    BOOL isLeftOpen;
    BOOL isRightOpen;
    BOOL isBottomOpen;
    
    NSMutableArray *msgNotifications;
}
@end

@implementation JIMContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // tableViewChat.layer.shadowColor = [UIColor blackColor].CGColor;
    //[self setShadowLeftToView:rightMenuBtnView];
    [self setShadowLeftToView:rightMenuView];
    //[self setShadowRightToView:leftMenuBtnView];
    [self setShadowRightToView:leftMenuView];
    [self setShadowToView:bottomMenuBgImgV];
    [self getMessageNotifications];
    //UINavigationController *navNewsFeedVC = [newsFeedStBoard instantiateViewControllerWithIdentifier:@"SBID_NewsFeedNav"];
    UIViewController *feedContainerVC = [newsFeedStBoard instantiateViewControllerWithIdentifier:@"SBID_FeedContainervc"];

    id profileVC = [newsFeedStBoard instantiateViewControllerWithIdentifier:@"SBID_ProfileVC"];
    //id chatVC  = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_ChatNav"];//
    id chatVC  = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_ChatListVC"];//

    id residentsVC = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_ResidentVC"];//SBID_ResidentsNav
    id myDiscoverVC = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_MyDiscoverVC"];
    self.tabbarController = self.childViewControllers[0];
    [self.tabbarController addChildViewController:feedContainerVC];//1
    [self.tabbarController addChildViewController:profileVC];//2
    [self.tabbarController addChildViewController:chatVC];//3
    [self.tabbarController addChildViewController:residentsVC];//4
    [self.tabbarController addChildViewController:myDiscoverVC]; //5
    
     if(appDelegate.isDirectLogin && profileEditing == NO)
     {
         [self showMenus];
         [self.tabbarController setSelectedIndex:1];
     }
    else
    {
        [self.tabbarController setSelectedIndex:0];
        leftMenuBtnView.hidden = YES;
        leftMenuView.hidden = YES;
        rightMenuView.hidden = YES;
        rightMenuBtnView.hidden = YES;
        bottomMenu.hidden = YES;
    }

    bottomMenuBottomSapce.constant = bottomMenuValue;
    
    [DefaultCenter addObserver:self selector:@selector(showMenusNotification:) name:@"MenuShowHideNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Bottom menu actions

- (IBAction)onClickEventMenu:(id)sender
{
    [self setTabbarSelectedIndex:1];
}
- (IBAction)onClickDiscoverMenu:(id)sender
{
    [self setTabbarSelectedIndex:5];
}

- (IBAction)onClickResidentsMenu:(id)sender
{
    [self setTabbarSelectedIndex:4];
}

- (IBAction)onClickProfileMenu:(id)sender
{
    [self setTabbarSelectedIndex:2];
    
}

#pragma mark - Right menu Button Action

- (IBAction)onClickAllMessageBtn:(id)sender
{
    [self setTabbarSelectedIndex:3];
}

#pragma mark - IBActions
- (IBAction)onRightMenuBtnTapped:(id)sender
{
    
    


    if(isRightOpen){
        [UIView animateWithDuration:0.5 animations:^{
            rightMenuTraillingSpace.constant = rightMenuValue;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            messageIcn.image = [UIImage imageNamed:@"chat_icon"];
        }];
        isRightOpen = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            rightMenuTraillingSpace.constant = 0;
            leftMenuLeadingSpace.constant = leftMenuValue;
            bottomMenuBottomSapce.constant = bottomMenuValue;
            
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            messageIcn.image = [UIImage imageNamed:@"minus_icon"];
        }];
        isRightOpen = YES;
        isLeftOpen = NO;
        isBottomOpen = NO;

    }

}

- (IBAction)onLeftMenuBtnTapped:(id)sender
{
   
    if(isLeftOpen){
        [UIView animateWithDuration:0.5 animations:^{
            leftMenuLeadingSpace.constant = leftMenuValue;
           
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
             notificatoinIcn.image = [UIImage imageNamed:@"notification_icon"];
        }];
        isLeftOpen = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            leftMenuLeadingSpace.constant = 0;
            rightMenuTraillingSpace.constant = rightMenuValue;
            bottomMenuBottomSapce.constant = bottomMenuValue;
           
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
             notificatoinIcn.image = [UIImage imageNamed:@"icMinusYellow"];
        }];
        isLeftOpen = YES;
        isRightOpen = NO;
        isBottomOpen = NO;

    }

}

- (IBAction)onBottomMenuBtnTapped:(id)sender
{
    //static BOOL isBottomOpen = NO;
    if(isBottomOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            bottomMenuBottomSapce.constant = bottomMenuValue;
            [self.view layoutIfNeeded];
        }];
        isBottomOpen = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            bottomMenuBottomSapce.constant = 0;
            leftMenuLeadingSpace.constant = leftMenuValue;
            rightMenuTraillingSpace.constant = rightMenuValue;
            [self.view layoutIfNeeded];
        }];
        isBottomOpen = YES;
        isLeftOpen = NO;
        isRightOpen = NO;
    }
}


#pragma mark - Tableview Delegate and data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfCell;
    if(tableView == tableViewChat) {
        if(msgNotifications == nil)
            numberOfCell = 1;
        else if(msgNotifications.count < 5)
            numberOfCell = msgNotifications.count + 1;
        else
            numberOfCell = 6;
    }
    else{
        numberOfCell = 6;
    }
    return  numberOfCell;
}
- (UITableViewCell *)tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableViewChat == tblView)
    {
        JFeedCell *cell;
        if (indexPath.row == ([tableViewChat numberOfRowsInSection:0] - 1))
        {
            cell = [tableViewChat dequeueReusableCellWithIdentifier:@"moreCell"];
            return cell;
        }
        
        cell = [tblView dequeueReusableCellWithIdentifier:@"cell"];
        JMessage *cht = msgNotifications[indexPath.row];
        cell.lblTitle.text = cht.senderName;
        cell.lblDescription.text = cht.text;
        cell.lblTime.text = TimeStringFromTime(cht.msgDateTime);
        return cell;
    }
    else
    {
     UITableViewCell *cell = [tblView dequeueReusableCellWithIdentifier:@"cell"];
        return  cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tblview heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableViewChat == tblview)
        return 35;
    else
        return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableViewChat){
        [self setTabbarSelectedIndex:3];
    }
    else
    {
        
    }
}

#pragma mark - other

- (void)setTabbarSelectedIndex:(int)index {
    [self.tabbarController setSelectedIndex:index];
    [UIView animateWithDuration:0.3 animations:^{
        bottomMenuBottomSapce.constant = bottomMenuValue;
        leftMenuLeadingSpace.constant = leftMenuValue;
        rightMenuTraillingSpace.constant = rightMenuValue;
        messageIcn.image = [UIImage imageNamed:@"chat_icon"];
        notificatoinIcn.image = [UIImage imageNamed:@"notification_icon"];
        [self.view layoutIfNeeded];
    }];

    
    isBottomOpen = NO;
    isRightOpen = NO;
    isLeftOpen  = NO;
}

- (void)showMenusNotification:(NSNotification*)notify
{
    [self showMenus];
}
- (void)showMenus
{
    BOOL choice;
    if(me)
        choice = NO;
    else
        choice = YES;
    
    bottomMenu.hidden = choice;
    leftMenuBtnView.hidden = choice;
    leftMenuView.hidden = choice;
    rightMenuView.hidden = choice;
    rightMenuBtnView.hidden = choice;
    
}

- (void)setShadowLeftToView:(UIView*)view
{
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.8];
    [view.layer setShadowRadius:3.0];
    [view.layer setShadowOffset:CGSizeMake(-3.0, 3.0)];
}
- (void)setShadowRightToView:(UIView*)view
{
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.8];
    [view.layer setShadowRadius:3.0];
    [view.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
}

- (void)setShadowToView:(UIView*)view
{
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.8];
    [view.layer setShadowRadius:5.0];
    [view.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
}

#pragma mark - WS CAll

- (void)getMessageNotifications {
    id param = @{@"user_screen_id": me.userID};
    [WSCall getChatList:param block:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                id arr = JSON[@"data"];
                msgNotifications = [NSMutableArray new];
                for(id jchat in arr)
                {
                    JMessage *chat = [JMessage new];
                    [chat setChatUser:jchat];
                    [msgNotifications addObject:chat];
                }
                [tableViewChat reloadData];
            }
        }
        else{
            
        }
    }];

}
@end
