//
//  JIMNewFeed.h
//  JustItMind
//
//  Created by Viksah on 12/24/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNewsFeed : NSObject
@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *discription;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *feedType;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *adminFirstName;
@property (nonatomic, strong) NSString *adminLastName;
@property (nonatomic, strong) NSString *profileImage;
@property (nonatomic) BOOL isJoined;

- (void)setFeedInfo: (NSDictionary *)info;
@end

@interface Comment : NSObject
@property (nonatomic, strong) NSString *commentID;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *strProfilePic;
@property (nonatomic, strong) NSString *userId;

- (void)setComment:(NSDictionary*)info;
@end