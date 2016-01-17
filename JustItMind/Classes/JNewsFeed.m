//
//  JIMNewFeed.m
//  JustItMind
//
//  Created by Viksah on 12/24/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JNewsFeed.h"

@implementation JNewsFeed

- (void)setFeedInfo: (NSDictionary *)info {
    self.feedId = info[@"id"];
    self.discription = info[@"news_feed_description"];
    self.title = info[@"news_feed_title"];
    self.startTime = info[@"starttime"];
    self.endTime = info[@"endtime"];
    self.feedType = info[@"news_feed_type"];
    self.location = info[@"location"];
    self.adminFirstName = info[@"firstname"];
    self.adminLastName = info[@"lastname"];
    self.userId = info[@"user_id"];
    self.profileImage = [NSString stringWithFormat:@"%@/%@", kImageBasePath, info[@"profile_pic_url"]];
    self.isJoined = [info[@"isJoined"] isEqualToString:@"no"] ? NO : YES;
}
@end



@implementation Comment

- (void)setComment:(NSDictionary*)info {
    self.commentID = info[@"id"];
    self.feedId = info[@"news_feed_id"];
    self.text = info[@"news_feed_comment"];
    self.userId = info[@"comment_by"];
    self.time = info[@"inserted_date"];
    self.userName = [NSString stringWithFormat:@"%@ %@", info[@"firstname"],info[@"lastname"]];
    self.strProfilePic = [NSString stringWithFormat:@"%@/%@",kImageBasePath, info[@"profile_pic_url"]];
}
@end