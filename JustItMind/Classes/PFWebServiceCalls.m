//
//  WSCalls.m
//  Wizit
//
//  Created by iOSDeveloper2 on 18/06/14.
//  Copyright (c) 2014 Yudiz Pvt Solution Ltd. All rights reserved.
//

#import "PFWebServiceCalls.h"
#import "SGConstants.h"
#import "AFNetworking.h"

static AFHTTPSessionManager *manager;

@interface PFWebServiceCalls()

+ (void)simpleGetRequestWithRelativePath:(NSString*)relativePath
                                                paramater:(NSDictionary*)param
                                                    block:(WSBlock)block;

+ (void)simplePostRequestWithRelativePath:(NSString*)relativePath
                                                 parameter:(NSDictionary*)param
                                                     block:(WSBlock)block;

+ (void)simpleMultipartPostRequestWithRelativePath:(NSString*)relativePath
                                                          parameter:(NSDictionary*)param
                                                              image:(UIImage*)image
                                                              block:(WSBlock)block;

@end


@implementation PFWebServiceCalls


+ (void)initialize
{
    manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kBasePath]];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves];
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            showAlertViewMessageTitle(@"Internet connection seems to be down.", @"No Internet");
        }
    }];
    [manager.reachabilityManager startMonitoring];
    
}


#pragma mark - Private Methods
//
+ (void)simpleGetRequestWithRelativePath:(NSString*)relativePath
                                                 paramater:(NSDictionary*)param
                                                     block:(WSBlock)block
{
    NSLog(@"Relative Path : %@",relativePath);
    NSLog(@"Param : %@",param);
    
     [manager GET:relativePath
             parameters:param
                success:^(NSURLSessionDataTask *task, id responseObject)
            {
                block(responseObject,WebServiceResultSuccess);
                
            }
                failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                NSLog(@"Error: %@",error);
                block(nil,WebServiceResultError);
                /* If error code is this ignore aler view. its due to internet connection. */
                if(error.code != -1009)
                    showAletViewWithMessage(error.localizedDescription);
            }];
}

/* Get method to fetch baby names not checking response flags. */
+ (void)babyNameGetRequestWithRelativePath:(NSString*)relativePath
                                                   paramater:(NSDictionary*)param
                                                       block:(WSBlock)block
{
    NSLog(@"Relative Path : %@",relativePath);
    NSLog(@"Param : %@",param);
    
     [manager GET:relativePath
             parameters:param
                success:^(NSURLSessionDataTask *task, id responseObject)
            {
                NSLog(@"Response : %@",responseObject);
                block(responseObject,WebServiceResultSuccess);
            }
                failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                NSLog(@"localizedDescription %@",error);
                block(nil,WebServiceResultError);
                if(error.code != -1009)
                    showAletViewWithMessage(error.localizedDescription);
            }];
}


+ (void)simplePostRequestWithRelativePath:(NSString*)relativePath
                                                 parameter:(NSDictionary*)param
                                                     block:(WSBlock)block
{
    NSLog(@"Relative Path : %@",relativePath);
    NSLog(@"Param : %@",param);
    
     [manager POST:relativePath
              parameters:param
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                //NSLog(@"Response : %@",responseObject);
                block(responseObject,WebServiceResultSuccess);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"localizedDescription %@",error);
                NSLog(@"localizedFailureReason %@",error.localizedFailureReason);
                NSLog(@"localizedRecoverySuggestion %@",error.localizedRecoverySuggestion);
                block(nil,WebServiceResultError);
                if(error.code != -1009)
                    showAletViewWithMessage(error.localizedDescription);
            }];
}

+ (void)simpleMultipartPostRequestWithRelativePath:(NSString*)relativePath
                                                          parameter:(NSDictionary*)param
                                                              image:(UIImage*)image
                                                              block:(WSBlock)block
{
    NSLog(@"Relative Path : %@",relativePath);
    NSLog(@"Param : %@",param);
    NSLog(@"Image : %@",image);
    
      [manager POST:relativePath
               parameters:param
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
             {
                 if(image)
                     [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5)
                                                 name:@"userfile"//NSImageNameStringFromCurrentDate()
                                             fileName:@"image.jpeg"
                                             mimeType:@"image/jpeg"];
                 
             } success:^(NSURLSessionDataTask *task, id responseObject)
             {
                 NSLog(@"Response : %@",responseObject);
                    block(responseObject,WebServiceResultSuccess);
             } failure:^(NSURLSessionDataTask *task, NSError *error)
             {
                 NSLog(@"localizedDescription %@",error);
                 NSLog(@"localizedFailureReason %@",error.localizedFailureReason);
                 NSLog(@"localizedRecoverySuggestion %@",error.localizedRecoverySuggestion);
                 block(nil,WebServiceResultError);
                 if(error.code != -1009)
                     showAletViewWithMessage(error.localizedDescription);
             }];
}

#pragma mark : JustInMind WS Methods

+ (NSDictionary*)parametersForOperation:(NSString*)method table:(NSString*)table otherParam:(NSDictionary*)param {
    NSMutableDictionary *dic  = [ NSMutableDictionary dictionaryWithDictionary:param];
    dic[@"json"] = @"";
    dic[@"method"] = method;
    dic[@"table"] = table;
    return dic;
}
+ (void)registerUserWithParam:(NSDictionary *)param block:(WSBlock)block
{
    NSLog(@"----------Register Student ws ---------");
    id params = [self parametersForOperation:@"add" table:@"user_profile" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

+ (void)updateProfileWithParam:(NSDictionary *)param block:(WSBlock)block
{
    id params = [self parametersForOperation:@"update" table:@"user_profile" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}







@end
