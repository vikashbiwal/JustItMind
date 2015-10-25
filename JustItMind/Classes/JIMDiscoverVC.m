//
//  JIMDiscoverVC.m
//  JustItMind
//
//  Created by Viksah on 9/27/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMDiscoverVC.h"
#import "JIMDiscoverCell.h"

@interface JIMDiscoverVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIScrollView *scrollview;
    
    IBOutlet UIButton *tabButton1;
    IBOutlet UIButton *tabButton2;
    IBOutlet UIButton *tabButton3;
    
    IBOutlet UIImageView *tabLine1;
    IBOutlet UIImageView *tabLine2;
    IBOutlet UIImageView *tabLine3;
    
    IBOutlet UIView *ideologyView;
    
    IBOutlet NSLayoutConstraint *parentViewWidth;
    
    
    NSInteger selectedTabIndex;
    NSMutableDictionary *selectedLifeStyeChoice;
    NSMutableDictionary *selectedArtsChoice;
}
@end

@implementation JIMDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    tabLine1.hidden = YES;
    selectedLifeStyeChoice = [NSMutableDictionary new];
    selectedArtsChoice = [NSMutableDictionary new];
    
    [self setUI];
}

- (void)setUI
{
    
    float width = screenSize.size.width;
    float height = screenSize.size.height - 96;
    [scrollview setContentSize:CGSizeMake(width, height)];
    parentViewWidth.constant = width*2;
}

#pragma mark - Tableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JIMDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"choiceCell"];
    [self setChoice:indexPath forCell:cell];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JIMDiscoverCell *headerView = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
#pragma mark - IBActions
- (IBAction)onDiscoverTabChange:(UIButton *)sender
{
     if(sender.tag == 1)
         discoverSelectedTab = DiscoverTabIdeology;
    else if (sender.tag == 2)
        discoverSelectedTab = DiscoverTabArts;
    else if(sender.tag == 3)
        discoverSelectedTab = DiscoverTabLifestyle;
    else if (sender.tag == 4)
        discoverSelectedTab = DiscoverTabResidents;
    [self setUIForSelectedTab];
}

- (IBAction)onChoiceBtnTap:(UIButton*)sender
{
    JIMDiscoverCell *cell = (id)sender.superview.superview;
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    NSMutableDictionary *choice = selectedTabIndex == 2 ? selectedArtsChoice : selectedLifeStyeChoice;
    if(choice[indexpath])
    {
        NSMutableDictionary *dic = choice[indexpath];
        if(dic[[NSNumber numberWithInteger:sender.tag]])
            [dic removeObjectForKey:[NSNumber numberWithInteger:sender.tag]];
        else
            [dic setObject:[NSNumber numberWithInteger:sender.tag] forKey:[NSNumber numberWithInteger:sender.tag]];
    }
    else
    {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic[[NSNumber numberWithInteger:sender.tag]]= [NSNumber numberWithInteger:sender.tag];
        [choice setObject:dic forKey:indexpath];
    }
        [sender setSelected:!sender.selected];
    
}

#pragma mark - Other
- (void)setChoice:(NSIndexPath*)path forCell:(JIMDiscoverCell*)cell
{
    NSMutableDictionary *choice = selectedTabIndex == 2 ? selectedArtsChoice : selectedLifeStyeChoice;
    if(choice[path])
    {
        if(choice[path][[NSNumber numberWithInteger:cell.button1.tag]])
          [cell.button1 setSelected:YES];
        else
            [cell.button1 setSelected:NO];
        
        if(choice[path][[NSNumber numberWithInteger:cell.button2.tag]])
            [cell.button2 setSelected:YES];
        else
            [cell.button2 setSelected:NO];
    }
    else
    {
        [cell.button1 setSelected:NO];
        [cell.button2 setSelected:NO];

    }
}

- (void)setUIForSelectedTab
{
    [self resetTabLine];
    int x;
    if([discoverSelectedTab isEqualToString:DiscoverTabIdeology])
         x = (screenSize.size.width/5) * 0;
    else if ([discoverSelectedTab isEqualToString:DiscoverTabArts])
        x = screenSize.size.width; //(screenSize.size.width/5) * 1;
    else if ([discoverSelectedTab isEqualToString:DiscoverTabLifestyle])
        x = 0;//(screenSize.size.width/5) * 2;
    else if ([discoverSelectedTab isEqualToString:DiscoverTabResidents])
        x = screenSize.size.width;//(screenSize.size.width/5) * 3;
    [scrollview setContentOffset:CGPointMake(x, 0) animated:NO];
    
}
- (void)resetTabLine
{
    tabLine1.hidden = NO;
    tabLine2.hidden = NO;
    tabLine3.hidden = NO;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
