//
//  Constant.m
//  ShiftCalendar
//
//  Created by iOSDeveloper2 on 03/10/13.
//  Copyright (c) 2013 Yudiz Pvt. Solution Ltd. All rights reserved.
//

#import "SGConstants.h"





NSMutableDictionary *userInformation = nil;
NSDateFormatter *_serverFormatter = nil;
inline bool is_iPhone5()
{
    if ([[UIScreen mainScreen] bounds].size.height==568)
        return YES;
    else
        return NO;
}

inline bool is_iPad()
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    else
        return NO;
}

 NSString* NSStringWithoutSpace(NSString* string)
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

 NSString* NSStringFromCurrentDate(void)
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddhhmmssSSS"];
    return [formatter stringFromDate:[NSDate date]];
}

NSString* NSStringFromBirthDate(NSDate* birthDate)
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    return [formatter stringFromDate:birthDate];
    
}

NSString* NSStringFromExpiryDate(NSString* expDate)
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *preFormatted = [formatter dateFromString:expDate];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"dd MMM yy"];
    return [formatter1 stringFromDate:preFormatted];
}

 NSString* NSImageNameStringFromCurrentDate(void)
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddhhmmssSSS"];
    NSString *imageName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
    return imageName;
}

 NSString* NSStringWithMergeofString(NSString* first,NSString* last)
{
    return [NSString stringWithFormat:@"%@ %@",first,last];
}

 NSString* NSStringFullname(NSDictionary* aDict)
{
    if(!aDict[@"vLast"] || ![aDict[@"vLast"] length])
        return aDict[@"vFirst"];
    else
        return [NSString stringWithFormat:@"%@ %@",aDict[@"vFirst"],aDict[@"vLast"]];
}

void showAletViewWithMessage(NSString* msg)
{
    [[[UIAlertView alloc]initWithTitle:@""
                                          message:msg
                                         delegate:nil
                                cancelButtonTitle:@"Dismiss"
                                otherButtonTitles:nil, nil]show];
  
}

void showAlertViewMessageTitle(NSString* msg,NSString* title)
{
    [[[UIAlertView alloc]initWithTitle:title
                               message:msg
                              delegate:nil
                     cancelButtonTitle:@"Dismiss"
                     otherButtonTitles:nil, nil]show];
    
}

NSString* AgoStringFromTime(NSDate* dateTime)
{
    NSDictionary *timeScale = @{@"s"  :@1,
                                @"m"  :@60,
                                @"h"   :@3600,
                                @"d"  :@86400,
                                @"w" :@605800,
                                @"M":@2629743,
                                @"y" :@31556926};
    NSString *scale;
    int timeAgo = 0-(int)[dateTime timeIntervalSinceNow];
    if (timeAgo < 60) {
        scale = @"s";
    } else if (timeAgo < 3600) {
        scale = @"m";
    } else if (timeAgo < 86400) {
        scale = @"h";
    } else if (timeAgo < 605800) {
        scale = @"d";
    } else if (timeAgo < 2629743) {
        scale = @"w";
    } else if (timeAgo < 31556926) {
        scale = @"M";
    } else {
        scale = @"y";
    }
    
    timeAgo = timeAgo/[[timeScale objectForKey:scale] integerValue];
//    NSString *s = @"";
//    if (timeAgo > 1) {
//        s = @"s";
//    }
    
    return [NSString stringWithFormat:@"%d %@", timeAgo, scale];
}
NSString* AgoFullStringFromTime(NSDate* dateTime)
{
    NSDictionary *timeScale = @{@"sec"  :@1,
                                @"minute"  :@60,
                                @"hour"   :@3600,
                                @"day"  :@86400,
                                @"week" :@605800,
                                @"Month":@2629743,
                                @"Year" :@31556926};
    NSString *scale;
    int timeAgo = 0-(int)[dateTime timeIntervalSinceNow];
    if (timeAgo < 60) {
        scale = @"sec";
    } else if (timeAgo < 3600) {
        scale = @"minute";
    } else if (timeAgo < 86400) {
        scale = @"hour";
    } else if (timeAgo < 605800) {
        scale = @"day";
    } else if (timeAgo < 2629743) {
        scale = @"week";
    } else if (timeAgo < 31556926) {
        scale = @"Month";
    } else {
        scale = @"Year";
    }
    
    timeAgo = timeAgo/[[timeScale objectForKey:scale] integerValue];
        NSString *s = @"";
        if (timeAgo > 1) {
            s = @"s";
        }
    
    return [NSString stringWithFormat:@"%d %@%@ ago", timeAgo, scale,s];
}

NSString *formattedStringFromTimeInterval(NSTimeInterval interval)
{
    int totalMin = interval/60;
    int remainSec = (int)interval%60;
    int totalHour = totalMin/60;
    int min = totalMin%60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",totalHour,min,remainSec];
}
NSString* DocumentDirectoryPath()
{
    
    NSArray *direcotries = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [direcotries firstObject];
}

NSString *getIPAddress()
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

NSString *convertToreadableDateFormat(NSString *dateStr)
{
   
    NSDate *ddt = [_serverFormatter dateFromString:dateStr];
    return AgoStringFromTime(ddt);
}
NSString *convertToreadableFullDateFormat(NSString *dateStr)
{
    
    NSDate *ddt = [_serverFormatter dateFromString:dateStr];
    return AgoFullStringFromTime(ddt);
}
BOOL CheckErrorWithCode(NSString *code) {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PFErrorCodeList" ofType:@"plist"];
    NSDictionary *errorDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return errorDic[code] ? YES : NO;
}
void showErrorMessageForError(NSString *errorCode)
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PFErrorCodeList" ofType:@"plist"];
    
    NSDictionary *errorDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *errorMessage = errorDic[errorCode][@"detail"];
   
    
    showAlertViewMessageTitle(errorMessage, @"PublicFeed");
}


