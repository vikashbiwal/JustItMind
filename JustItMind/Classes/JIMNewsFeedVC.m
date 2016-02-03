//
//  JIMNewsFeedVC.m
//  JustItMind
//
//  Created by Viksah on 9/28/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMNewsFeedVC.h"
#import "JNewsFeed.h"
#import "TableViewCells.h"
#import "UIImageView+AFNetworking.h"
#import "JIMEventDeailVC.h"

@interface JIMNewsFeedVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet NSLayoutConstraint *tableviewWidth;
    IBOutlet NSLayoutConstraint *topMenuTopSpace;
    NSMutableArray *arrNewsFeed;
    UIRefreshControl *refControl;
}
@end

@implementation JIMNewsFeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    topMenuTopSpace.constant = -50;
    tableviewWidth.constant = screenSize.size.width;
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    SEL refSelector;
    if(self.tableView.tag == 11) {
        [self getNewsFeedWS];
        refSelector = @selector(getNewsFeedWS);
    }
    else {
        [self getDormFeed];
        refSelector = @selector(getDormFeed);
    }
    refControl = [[UIRefreshControl alloc]init];
    [refControl addTarget:self action:refSelector forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refControl];
}


#pragma mark - TAbleview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrNewsFeed.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JNewsFeed *feed = arrNewsFeed[indexPath.row];
    JFeedCell *cell;
    if([feed.feedType isEqualToString:@"message"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"advetCell"];
        cell.lblDescription.text = feed.discription;
    }
    else if([feed.feedType isEqualToString:@"drom_feed"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"advetCell"];
        cell.lblDescription.text = feed.discription;
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"eventFeedCell"];
        cell.lblTitle.text = feed.title;
        cell.lblDate.text = feed.startTime;
        cell.lblTime.text = feed.endTime;

    }
    [cell.imgView setImageWithURL:[NSURL URLWithString:feed.profileImage] placeholderImage:[UIImage imageNamed:@"photo_bg"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JNewsFeed *feed = arrNewsFeed[indexPath.row];
    if ([feed.feedType isEqualToString:@"magicevent"]) {
    [self performSegueWithIdentifier:@"EventDetailSegue" sender:arrNewsFeed[indexPath.row]];
    }
}

- (IBAction)onTopMenuShutterBtn:(id)sender
{
    static BOOL isOpend = NO;
    if(isOpend)
    {
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = -50;
            [self.view layoutIfNeeded];
        }];
        isOpend = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            topMenuTopSpace.constant = 64;
            [self.view layoutIfNeeded];
        }];
        isOpend = YES;
    }
}

#pragma mark - IBActions

- (IBAction)onCellProfile:(id)sender {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebService methods

- (void)getNewsFeedWS {

    id param = @{@"join_user_id":me.userID};
    if(!refControl.isRefreshing)
        [self showHud];
    [WSCall getNewsFeeds:param block:^(id JSON, WebServiceResult result) {
        [self hideHud];
        [refControl endRefreshing];
        if(result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                NSArray *arrData = JSON[@"data"];
                arrNewsFeed = [NSMutableArray new];
                for (NSDictionary *obj in  arrData) {
                    JNewsFeed *feed = [JNewsFeed new];
                    [feed setFeedInfo:obj];
                    [arrNewsFeed addObject:feed];
                }
                arrNewsFeed = (id)[self sortArray:arrNewsFeed fieldName:@"feedDate"];

                [self.tableView reloadData];
            }
        }
        else {
            
        }
    }];
}

- (void)getDormFeed {
    id param = @{@"news_feed_type": @"drom_feed"};
    if(!refControl.isRefreshing)
        [self showHud];
    [WSCall getDormFeeds:param block:^(id JSON, WebServiceResult result) {
        [refControl endRefreshing];
        [self hideHud];
        if(result == WebServiceResultSuccess) {
            if ([JSON[@"status"] intValue] == 1) {
                NSArray *arrData = JSON[@"data"];
                arrNewsFeed = [NSMutableArray new];
                for (NSDictionary *obj in  arrData) {
                    JNewsFeed *feed = [JNewsFeed new];
                    [feed setFeedInfo:obj];
                    [arrNewsFeed addObject:feed];
                }
                arrNewsFeed = (id)[self sortArray:arrNewsFeed fieldName:@"feedDate"];
                [self.tableView reloadData];
            }
            else
            {
            
            }
        }
        else
        {
        }
    }];
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"EventDetailSegue"]) {
        JIMEventDeailVC *eventDVC = segue.destinationViewController;
        eventDVC.eventFeed = sender;
    }
}


@end
