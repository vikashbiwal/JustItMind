//
//  JIMDiscoverVC.m
//  JustItMind
//
//  Created by Viksah on 9/27/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMDiscoverVC.h"
#import "JIMDiscoverCell.h"

@interface JIMDiscoverVC ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UICollectionView *tabBtnCollView;
    
    IBOutlet UIButton *tabButton1;
    IBOutlet UIButton *tabButton2;
    IBOutlet UIButton *tabButton3;
    
    IBOutlet UIImageView *tabLine1;
    IBOutlet UIImageView *tabLine2;
    IBOutlet UIImageView *tabLine3;
    
    IBOutlet UIView *ideologyView;
    
    IBOutlet NSLayoutConstraint *button1Width;
    IBOutlet NSLayoutConstraint *button2Width;
    IBOutlet NSLayoutConstraint *button3Width;
    IBOutlet NSLayoutConstraint *button2LeadingSpace;
    
    IBOutlet NSLayoutConstraint *tabLine1Width;
    IBOutlet NSLayoutConstraint *tabLine2Width;
    IBOutlet NSLayoutConstraint *tabLine3Width;
    IBOutlet NSLayoutConstraint *tabLine2Leading;
    
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
    [tabBtnCollView setContentInset:UIEdgeInsetsFromString(@"{-20.0,0.0,0.0,0.0}")];
    if(screenSize.size.width == 375)
    {
        button1Width.constant = 127;
        button2Width.constant = 127;
        button3Width.constant = 128;
        button2LeadingSpace.constant = 126;
        
        tabLine1Width.constant = 126;
        tabLine2Width.constant = 124;
        tabLine3Width.constant = 125;
        tabLine2Leading.constant = 126;
    }
    else if (screenSize.size.width == 414)
    {
        button1Width.constant = 141;
        button2Width.constant = 141;
        button3Width.constant = 140;
        button2LeadingSpace.constant = 140;
        
        tabLine1Width.constant = 140;
        tabLine2Width.constant = 137;
        tabLine3Width.constant = 137;
        tabLine2Leading.constant = 140;
    }
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
    selectedTabIndex = sender.tag;
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
    if(selectedTabIndex == 1)
    {
        tabLine1.hidden = YES;
        self.tableView.hidden = YES;
        ideologyView.hidden = NO;
    }
    else if (selectedTabIndex == 2)
    {    tabLine2.hidden  = YES;
       ideologyView.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
    else if (selectedTabIndex == 3)
    {    tabLine3.hidden = YES;
        ideologyView.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
}
- (void)resetTabLine
{
    tabLine1.hidden = NO;
    tabLine2.hidden = NO;
    tabLine3.hidden = NO;
    
}


#pragma mark collectionView datasource delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tabBtnCell" forIndexPath:indexPath];
    return  cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = screenSize.size.width/3;
    return CGSizeMake(width, 40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
