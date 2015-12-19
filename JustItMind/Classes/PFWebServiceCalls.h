//
//  WSCalls.h
//  Wizit
//
//  Created by iOSDeveloper2 on 18/06/14.
//  Copyright (c) 2014 Yudiz Pvt Solution Ltd. All rights reserved.
//

@import Foundation;
@import UIKit;

#define kBasePath @"http://api.cianinfosolutions.com/justmind/control.php"

typedef NS_ENUM (NSInteger, WebServiceResult)
{
    WebServiceResultSuccess = 0,
    WebServiceResultFail,
    WebServiceResultError
};

typedef void(^WSBlock)(id JSON,WebServiceResult result);



@interface PFWebServiceCalls : NSObject

+ (void)registerUserWithParam:(NSDictionary*)param block:(WSBlock)block;
+ (void)updateProfileWithParam:(NSDictionary *)param block:(WSBlock)block;
+ (void)updateImage:(UIImage*)image param:(NSDictionary*)param fieldName:(NSString*)fieldname block:(WSBlock)block;

#pragma mark - Credential WS calls


@end
