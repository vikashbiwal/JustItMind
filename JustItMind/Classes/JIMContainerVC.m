//
//  JIMContainerVC.m
//  JustItMind
//
//  Created by Viksah on 9/29/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMContainerVC.h"

//#define newsFeedStBoard [UIStoryboard storyboardWithName:@"NewsFeed" bundle:nil]
@interface JIMContainerVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableViewChat;
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
    
    [view.layer setShadowOffset:CGSizeMake(3.0, 3.0)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // tableViewChat.layer.shadowColor = [UIColor blackColor].CGColor;
    [self setShadowLeftToView:rightMenuBtnView];
    [self setShadowLeftToView:rightMenuView];
    [self setShadowRightToView:leftMenuBtnView];
    [self setShadowRightToView:leftMenuView];
    
    UINavigationController *navNewsFeedVC = [newsFeedStBoard instantiateViewControllerWithIdentifier:@"SBID_NewsFeedNav"];
    self.tabbarController = self.childViewControllers[0];
    [self.tabbarController addChildViewController:navNewsFeedVC];
    [self.tabbarController setSelectedIndex:0];
    
    bottomMenuBottomSapce.constant = -170;
    [self showMenus];
    [DefaultCenter addObserver:self selector:@selector(showMenusNotification:) name:@"MenuShowHideNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions
- (IBAction)onRightMenuBtnTapped:(id)sender
{
    //static BOOL isRightOpen = NO;
    
//    UINavigationController *chatNav = [ChatStBoard instantiateViewControllerWithIdentifier:@"SBID_ChatNav"];
//    [self.tabbarController addChildViewController:chatNav];
//    [self.tabbarController setSelectedIndex:2];

    if(isRightOpen){
        [UIView animateWithDuration:0.5 animations:^{
            rightMenuTraillingSpace.constant = -200;
            [self.view layoutIfNeeded];
        }];
        isRightOpen = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            rightMenuTraillingSpace.constant = 0;
            leftMenuLeadingSpace.constant = -200;
            bottomMenuBottomSapce.constant = -170;
            [self.view layoutIfNeeded];
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
            leftMenuLeadingSpace.constant = -200;
            [self.view layoutIfNeeded];
        }];
        isLeftOpen = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            leftMenuLeadingSpace.constant = 0;
            rightMenuTraillingSpace.constant = -200;
            bottomMenuBottomSapce.constant = -170;
            [self.view layoutIfNeeded];
        }];
        isLeftOpen = YES;
        isRightOpen = NO;
        isBottomOpen = NO;

    }

}

- (IBAction)onBottomMenuBtnTapped:(id)sender
{
    //static BOOL isBottomOpen = NO;
    if(isBottomOpen){
        [UIView animateWithDuration:0.5 animations:^{
            bottomMenuBottomSapce.constant = -170;
            [self.view layoutIfNeeded];
        }];
        isBottomOpen = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            bottomMenuBottomSapce.constant = 0;
            leftMenuLeadingSpace.constant = -125;
            rightMenuTraillingSpace.constant = -125;
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
    if(userInformation)
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
@end
