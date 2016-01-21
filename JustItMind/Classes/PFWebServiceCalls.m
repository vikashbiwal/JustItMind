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

+ (void)simpleMultipartPostRequestWithRelativePath:(NSString*)relativePath  parameter:(NSDictionary*)param  image:(UIImage*)image fieldname:(NSString*)fieldname block:(WSBlock)block;

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

+ (void)simpleMultipartPostRequestWithRelativePath:(NSString*)relativePath parameter:(NSDictionary*)param image:(UIImage*)image fieldname:(NSString*)fieldname block:(WSBlock)block {
    NSLog(@"Relative Path : %@",relativePath);
    NSLog(@"Param : %@",param);
    NSLog(@"Image : %@",image);
      [manager POST:relativePath parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
             {
                 if(image)
                     [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:fieldname fileName:@"image.jpeg" mimeType:@"image/jpeg"];
             } success:^(NSURLSessionDataTask *task, id responseObject)
             {
                NSLog(@"Response : %@",responseObject);
                block(responseObject,WebServiceResultSuccess);
             } failure:^(NSURLSessionDataTask *task, NSError *error)
             {
                 NSLog(@"localizedDescription %@",error);
                 block(nil,WebServiceResultError);
             }];
}

#pragma mark : JustInMind WS Methods

+ (NSDictionary*)parametersForOperation:(NSString*)method table:(NSString*)table otherParam:(NSDictionary*)param {
    NSMutableDictionary *dic;
    if (param) {
        dic  = [ NSMutableDictionary dictionaryWithDictionary:param];
    }
    else{
        dic  = [ NSMutableDictionary new];
    }
    dic[@"json"] = @"";
    dic[@"method"] = method;
    dic[@"table"] = table;
    return dic;
}
+ (void)registerUserWithParam:(NSDictionary *)param block:(WSBlock)block
{
    NSLog(@"----------Register Student ws ---------");
    id params = [self parametersForOperation:@"selectadd" table:@"user_profile" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

+ (void)updateProfileWithParam:(NSDictionary *)param block:(WSBlock)block
{
    id params = [self parametersForOperation:@"update" table:@"user_profile" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

+ (void)updateImage:(UIImage*)image param:(NSDictionary*)param fieldName:(NSString*)fieldname block:(WSBlock)block
{
    NSLog(@"----------update image---------");
    id params = [self parametersForOperation:@"update" table:@"user_profile" otherParam:param];
   
    [self simpleMultipartPostRequestWithRelativePath:@"" parameter:params image:image fieldname:fieldname block:block];
}

+ (void)getUserProfile:(NSDictionary *)param block:(WSBlock)block {
    NSLog(@"----------get User profile info---------");
    id params = [self parametersForOperation:@"find" table:@"user_profile" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

+ (void)createEvent:(NSDictionary*)param block:(WSBlock)block {
    NSLog(@"----------create Event ws---------");
    id params = [self parametersForOperation:@"add" table:@"news_feed" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

+ (void)getNewsFeeds:(NSDictionary*)param block:(WSBlock)block {
    NSLog(@"----------Get NewsFeed List ws---------");
    id params = [self parametersForOperation:@"news_feed_list" table:@"" otherParam:nil];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

//api.cianinfosolutions.com/justmind/control.php?json=&method=find&table=news_feed&news_feed_type=magicevent&user_id=19
+ (void)getDormFeeds:(NSDictionary *)param block:(WSBlock)block {
    NSLog(@"----------get dorm feed list ws---------");
    id params = [self parametersForOperation:@"drom_feed_list" table:@"" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

//api.cianinfosolutions.com/justmind/control.php?json=&method=selectadd&table=join_event&userid=1&eventid=1
+ (void)joinEvent:(NSDictionary *)param block:(WSBlock)block {
    NSLog(@"----------Join Event ws---------");
    id params = [self parametersForOperation:@"selectadd" table:@"join_event" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

//api.cianinfosolutions.com/justmind/control.php?json=&table=news_feed_comment&method=add&news_feed_id=1&news_feed_comment=comment&comment_by=1&inserted_date=date
+ (void)addCommentOnEvent:(NSDictionary*)param block:(WSBlock)block {
    NSLog(@"----------Add Comment ws---------");
    id params = [self parametersForOperation:@"add" table:@"news_feed_comment" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

//api.cianinfosolutions.com/justmind/control.php?json=&table=news_feed_comment&method=find&news_feed_id=1
+ (void)getCommentsOfFeed:(NSDictionary *)param block:(WSBlock)block {
    NSLog(@"----------get Comments ws---------");
    id params = [self parametersForOperation:@"find" table:@"news_feed_comment" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

+ (void)getUsersFeed:(NSDictionary*)param block:(WSBlock)block {
    NSLog(@"----------get user specific feed ws---------");
    id params = [self parametersForOperation:@"find" table:@"news_feed" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

+ (void)getUsers:(NSDictionary*)param block:(WSBlock)block {
    NSLog(@"----------get RA user list ws---------");
    id params = [self parametersForOperation:@"find" table:@"user_profile" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

//api.cianinfosolutions.com/justmind/control.php?json=&table=msg_chat&method=add&msg=fdsfasd&to=1&from=19
+ (void)sendChatMessage:(NSDictionary*)param block:(WSBlock)block {
    NSLog(@"----------sendChatMessage ws---------");
    id params = [self parametersForOperation:@"add" table:@"msg_chat" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}

//api.cianinfosolutions.com/justmind/control.php?json=&method=sender_chat_list&table=msg_chat&to=1&from=19
+ (void)getChatConversationBetweenTwoUser:(NSDictionary*)param block:(WSBlock)block {
    NSLog(@"----------getChatConversation ws---------");
    id params = [self parametersForOperation:@"sender_chat_list" table:@"msg_chat" otherParam:param];
    [self simpleGetRequestWithRelativePath:@"" paramater:params block:block];
}
@end
