//
//  JIMContainerVC.m
//  JustItMind
//
//  Created by Viksah on 9/29/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMContainerVC.h"

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
}
@end

@implementation JIMContainerVC

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
- (void)viewDidLoad {
    [super viewDidLoad];
    
   // tableViewChat.layer.shadowColor = [UIColor blackColor].CGColor;
    //[self setShadowLeftToView:rightMenuBtnView];
    [self setShadowLeftToView:rightMenuView];
    //[self setShadowRightToView:leftMenuBtnView];
    [self setShadowRightToView:leftMenuView];
    [self setShadowToView:bottomMenuBgImgV];
    UINavigationController *navNewsFeedVC = [newsFeedStBoard instantiateViewControllerWithIdentifier:@"SBID_NewsFeedNav"];
    id profileVC = [newsFeedStBoard instantiateViewControllerWithIdentifier:@"SBID_ProfileVC"];
    id chatVC  = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_ChatNav"];
    id residentsVC = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_ResidentVC"];//SBID_ResidentsNav
    id myDiscoverVC = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_MyDiscoverVC"];
    self.tabbarController = self.childViewControllers[0];
    [self.tabbarController addChildViewController:navNewsFeedVC];//1
    [self.tabbarController addChildViewController:profileVC];//2
    [self.tabbarController addChildViewController:chatVC];//3
    [self.tabbarController addChildViewController:residentsVC];//4
    [self.tabbarController addChildViewController:myDiscoverVC]; //5
    
     if(appDelegate.isDirectLogin)
         [self.tabbarController setSelectedIndex:1];
    else
        [self.tabbarController setSelectedIndex:0];

    bottomMenuBottomSapce.constant = bottomMenuValue;
    [self showMenus];
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

#pragma mark - Other
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

#pragma Tableview Delegate and data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableViewChat == tblView)
    {
    UITableViewCell *cell = [tblView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row == 5)
        cell = [tableViewChat dequeueReusableCellWithIdentifier:@"moreCell"];
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
            UINavigationController *chatNav = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_ChatNav"];
            [self.tabbarController addChildViewController:chatNav];
            [self.tabbarController setSelectedIndex:2];
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
@end
