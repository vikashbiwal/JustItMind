//
//  JIMNewFeed.m
//  JustItMind
//
//  Created by Viksah on 12/24/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "JIMNewFeed.h"

@implementation JIMNewFeed

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
}
@end
