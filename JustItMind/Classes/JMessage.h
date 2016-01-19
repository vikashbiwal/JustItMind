//
//  JMessage.h
//  JustItMind
//
//  Created by Viksah on 1/18/16.
//  Copyright (c) 2016 Viksah Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMessage : NSObject
@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *senderID;
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *senderProfilePic;
@property (nonatomic, strong) NSString *strTime;

- (void)setMessage:(NSDictionary*)info ;

@end
