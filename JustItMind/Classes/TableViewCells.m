//
//  TableViewCells.m
//  JustItMind
//
//  Created by Viksah on 12/27/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "TableViewCells.h"
#import "JNewsFeed.h"
#import "UIImageView+AFNetworking.h"

@implementation JFeedCell

- (void)awakeFromNib {
    // Initialization code
    self.imgView.layer.cornerRadius = self.imgView.frame.size.height/2;
    self.imgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


// profile cell
@interface JProfileCell () <UITableViewDataSource, UITableViewDelegate>

@end
@implementation JProfileCell

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _arrFeeds.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JNewsFeed *feed = _arrFeeds[indexPath.row];
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

- (void)reloadFeeds {
    [_tableview reloadData];
}

#pragma mark - tablview datasource and delegate

@end