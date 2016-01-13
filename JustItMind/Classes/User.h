//
//  User.h
//  JustItMind
//
//  Created by Viksah on 12/3/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *verificationCode;
@property (strong, nonatomic) NSString *universityID;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *grYear;
@property (strong, nonatomic) NSString *major;
@property (strong, nonatomic) NSString *regHall;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSString *userType;
@property (strong, nonatomic) NSString *profileImageUrl;
@property (strong, nonatomic) NSString *coverImageUrl;
- (void)setInfo:(NSDictionary*)info;

@end
