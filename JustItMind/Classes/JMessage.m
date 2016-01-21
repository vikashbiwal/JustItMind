//
//  JMessage.m
//  JustItMind
//
//  Created by Viksah on 1/18/16.
//  Copyright (c) 2016 Viksah Kumar. All rights reserved.
//

#import "JMessage.h"

@implementation JMessage

- (void)setMessage:(NSDictionary*)info {
    self.msgId = info[@"id"];
    self.text = info[@"msg"];
    self.senderID = info[@"sender_id"];
    self.senderName = [NSString stringWithFormat:@"%@ %@", info[@"sender_firstname"],info[@"sender_lastname"]];
    self.senderProfilePic = [NSString stringWithFormat:@"%@/%@", kImageBasePath, info[@"sender_profile_pic_url"]];
    self.strTime = info[@"time"];
}
@end
