//
//  User.m
//  JustItMind
//
//  Created by Viksah on 12/3/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "User.h"

@implementation User

- (void)setInfo:(NSDictionary*)info
{ 
    _userID         = info[@"id"];
    _universityID   = info[@"university_id"];
    _email          = info[@"universityemail"];
    _firstName      = info[@"firstname"];
    _lastName       = info[@"lastname"];
    _grYear         = info[@"graduation_year"];
    _regHall        = info[@"resident_hall"];
    _major          = info[@"major"];
    _verificationCode = info[@"randomCode"];
    _bio            = info[@"bio"];
    _profileImageUrl = [NSString stringWithFormat:@"%@/%@", kImageBasePath, info[@"profile_pic_url"]];
    _userType        = kUserTypeRA; //kUserTypeStudent
    _coverImageUrl  = info[@"show_profile_pic"];
}
@end
