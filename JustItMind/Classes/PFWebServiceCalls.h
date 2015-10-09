//
//  WSCalls.h
//  Wizit
//
//  Created by iOSDeveloper2 on 18/06/14.
//  Copyright (c) 2014 Yudiz Pvt Solution Ltd. All rights reserved.
//

@import Foundation;
@import UIKit;

#define kBasePath @"http://test.publicfeed.com/"
#define kProxiBasePath @"http://test.publicfeed.com/src/"

typedef NS_ENUM (NSInteger, WebServiceResult)
{
    WebServiceResultSuccess = 0,
    WebServiceResultFail,
    WebServiceResultError
};

typedef void(^WebCallBlockSession)(id JSON,WebServiceResult result);



@interface PFWebServiceCalls : NSObject


#pragma mark - Credential WS calls


@end
