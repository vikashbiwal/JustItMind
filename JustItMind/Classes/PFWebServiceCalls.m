//
//  WSCalls.m
//  Wizit
//
//  Created by iOSDeveloper2 on 18/06/14.
//  Copyright (c) 2014 Yudiz Pvt Solution Ltd. All rights reserved.
//

#import "PFWebServiceCalls.h"
#import "SGConstants.h"

//static AFHTTPSessionManager *manager;
//static AFHTTPSessionManager *proxiManager;

@interface PFWebServiceCalls()

+ (NSURLSessionDataTask*)simpleGetRequestWithRelativePath:(NSString*)relativePath
                                                paramater:(NSDictionary*)param
                                                    block:(WebCallBlockSession)block;

+ (NSURLSessionDataTask*)simplePostRequestWithRelativePath:(NSString*)relativePath
                                                 parameter:(NSDictionary*)param
                                                     block:(WebCallBlockSession)block;

+ (NSURLSessionDataTask*)simpleMultipartPostRequestWithRelativePath:(NSString*)relativePath
                                                          parameter:(NSDictionary*)param
                                                              image:(UIImage*)image
                                                              block:(WebCallBlockSession)block;

@end


@implementation PFWebServiceCalls


+ (void)initialize
{
//    manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kBasePath]];
//    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves];
//    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if(status == AFNetworkReachabilityStatusNotReachable){
//            showAlertViewMessageTitle(@"Internet connection seems to be down.", @"No Internet");
//        }
//    }];
//    [manager.reachabilityManager startMonitoring];
//    
//    ///////////////// not use rightnow/////////
//    proxiManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kProxiBasePath]];
//    proxiManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves];
    /////////////////////
}


#pragma mark - Private Methods
//
//+ (NSURLSessionDataTask *)simpleGetRequestWithRelativePath:(NSString*)relativePath
//                                                 paramater:(NSDictionary*)param
//                                                     block:(WebCallBlockSession)block
//{
//    NSLog(@"Relative Path : %@",relativePath);
//    NSLog(@"Param : %@",param);
//    
//    return [manager GET:relativePath
//             parameters:param
//                success:^(NSURLSessionDataTask *task, id responseObject)
//            {
//                NSLog(@"Response: %@",responseObject);
//                /*  Check if object is array or dictionary.
//                 If Dictionary, check for error_code flag.
//                 If its availabke than check its value. */
//                if([responseObject isKindOfClass:[NSArray class]]) {
//                    block(responseObject,WebServiceResultSuccess);
//                }
//                else {
//                    if(responseObject[@"error_code"])
//                    {
//                        // if value of error code is 1, It will be error.
//                        int errorCode = [responseObject[@"error_code"] intValue];
//                        if(errorCode == 0)
//                            block(responseObject,WebServiceResultSuccess);
//                        else {
//                            showAletViewWithMessage(responseObject[@"error_message"]);
//                            block(responseObject,WebServiceResultFail);
//                        }
//                    }
//                    else
//                        block(responseObject,WebServiceResultSuccess);
//                }
//            }
//                failure:^(NSURLSessionDataTask *task, NSError *error)
//            {
//                NSLog(@"Error: %@",error);
//                block(nil,WebServiceResultError);
//                /* If error code is this ignore aler view. its due to internet connection. */
//                if(error.code != -1009)
//                    showAletViewWithMessage(error.localizedDescription);
//            }];
//}
//
///* Get method to fetch baby names not checking response flags. */
//+ (NSURLSessionDataTask *)babyNameGetRequestWithRelativePath:(NSString*)relativePath
//                                                   paramater:(NSDictionary*)param
//                                                       block:(WebCallBlockSession)block
//{
//    NSLog(@"Relative Path : %@",relativePath);
//    NSLog(@"Param : %@",param);
//    
//    return [manager GET:relativePath
//             parameters:param
//                success:^(NSURLSessionDataTask *task, id responseObject)
//            {
//                NSLog(@"Response : %@",responseObject);
//                block(responseObject,WebServiceResultSuccess);
//            }
//                failure:^(NSURLSessionDataTask *task, NSError *error)
//            {
//                NSLog(@"localizedDescription %@",error);
//                block(nil,WebServiceResultError);
//                if(error.code != -1009)
//                    showAletViewWithMessage(error.localizedDescription);
//            }];
//}
//
//
//+ (NSURLSessionDataTask*)simplePostRequestWithRelativePath:(NSString*)relativePath
//                                                 parameter:(NSDictionary*)param
//                                                     block:(WebCallBlockSession)block
//{
//    NSLog(@"Relative Path : %@",relativePath);
//    NSLog(@"Param : %@",param);
//    
//    return [manager POST:relativePath
//              parameters:param
//                 success:^(NSURLSessionDataTask *task, id responseObject) {
//                //NSLog(@"Response : %@",responseObject);
//                
//                block(responseObject,WebServiceResultSuccess);
//            
//            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                NSLog(@"localizedDescription %@",error);
//                NSLog(@"localizedFailureReason %@",error.localizedFailureReason);
//                NSLog(@"localizedRecoverySuggestion %@",error.localizedRecoverySuggestion);
//                block(nil,WebServiceResultError);
//                if(error.code != -1009)
//                    showAletViewWithMessage(error.localizedDescription);
//            }];
//}
//
//+ (NSURLSessionDataTask*)simpleMultipartPostRequestWithRelativePath:(NSString*)relativePath
//                                                          parameter:(NSDictionary*)param
//                                                              image:(UIImage*)image
//                                                              block:(WebCallBlockSession)block
//{
//    NSLog(@"Relative Path : %@",relativePath);
//    NSLog(@"Param : %@",param);
//    NSLog(@"Image : %@",image);
//    
//    return  [manager POST:relativePath
//               parameters:param
//constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//             {
//                 if(image)
//                     [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5)
//                                                 name:@"userfile"//NSImageNameStringFromCurrentDate()
//                                             fileName:@"image.jpeg"
//                                             mimeType:@"image/jpeg"];
//                 
//             } success:^(NSURLSessionDataTask *task, id responseObject)
//             {
//                 NSLog(@"Response : %@",responseObject);
//                 /*  Check if object is array or dictionary.
//                  If Dictionary, check for error_code flag.
//                  If its availabke than check its value. */
//                 if([responseObject isKindOfClass:[NSArray class]]) {
//                     block(responseObject,WebServiceResultSuccess);
//                 }
//                 else {
//                     if(responseObject[@"error_code"])
//                     {
//                         // if value of error code is 1, It will be error.
//                         int errorCode = [responseObject[@"error_code"] intValue];
//                         if(errorCode == 0)
//                             block(responseObject,WebServiceResultSuccess);
//                         else {
//                             showAletViewWithMessage(responseObject[@"error_message"]);
//                             block(responseObject,WebServiceResultFail);
//                         }
//                     }
//                     else
//                         block(responseObject,WebServiceResultSuccess);
//                 }
//             } failure:^(NSURLSessionDataTask *task, NSError *error)
//             {
//                 NSLog(@"localizedDescription %@",error);
//                 NSLog(@"localizedFailureReason %@",error.localizedFailureReason);
//                 NSLog(@"localizedRecoverySuggestion %@",error.localizedRecoverySuggestion);
//                 block(nil,WebServiceResultError);
//                 if(error.code != -1009)
//                     showAletViewWithMessage(error.localizedDescription);
//             }];
//}
//
//
//
//
//
//
//
//
//

@end
