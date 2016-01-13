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
    [self getNewsFeedWS];
    refControl = [[UIRefreshControl alloc]init];
    [refControl addTarget:self action:@selector(getNewsFeedWS) forControlEvents:UIControlEventValueChanged];
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
    [self performSegueWithIdentifier:@"EventDetailSegue" sender:arrNewsFeed[indexPath.row]];

//    if(indexPath.row%2 == 0)
//    {
//    [self performSegueWithIdentifier:@"EventDetailSegue" sender:nil];
//    }
//    else
//    {
//        [self performSegueWithIdentifier:@"coupanDetailSegue" sender:nil];
//        
//    }
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
    

    id param = @{@"userid":me.userID};
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
                [self.tableView reloadData];
            }
        }
        else {
            
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
