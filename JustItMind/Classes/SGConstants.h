//
//  Constant.h
//  ShiftCalendar
//
//  Created by iOSDeveloper2 on 03/10/13.
//  Copyright (c) 2013 Yudiz Pvt. Solution Ltd. All rights reserved.
//




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>
#import "PFWebServiceCalls.h"
#import "PFWebServiceCalls.h"
#include <ifaddrs.h>
#include <arpa/inet.h>


#define IsAtLeastiOSVersion(X) ([[[UIDevice currentDevice] systemVersion] compare:X options:NSNumericSearch] != NSOrderedAscending)

#define _COLOR(R,G,B,ALPHA) [[UIColor alloc]initWithRed:(float)R/255 green:(float)G/255 blue:(float)B/255 alpha:ALPHA]

#define __APP_FONT(X)           [UIFont fontWithName:@"HelveticaNeue" size:X]
#define __APP_BOLD_FONT(X)      [UIFont fontWithName:@"HelveticaNeue-Medium" size:X]
#define __APP_DEFAULT_FONT(X)   [UIFont fontWithName:@"CaeciliaCom-55Roman" size:X]


#define UserDefault   [NSUserDefaults standardUserDefaults]
#define DefaultCenter [NSNotificationCenter defaultCenter]
#define Appdelegate ((PFAppDelegate *)[[UIApplication sharedApplication] delegate])
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define __Holder_Image [UIImage imageNamed:@"_holder"]
#define kLocalNotificationTime (6*60*60)
#define screenSize [[UIScreen mainScreen] bounds]
#define newsFeedStBoard [UIStoryboard storyboardWithName:@"NewsFeed" bundle:nil]
extern NSMutableDictionary *userInformation;

extern NSDateFormatter *_serverFormatter;

/* device check */
extern inline bool is_iPhone5();
extern inline bool is_iPad();


/* C functions */
extern  NSString* NSStringWithoutSpace(NSString* string);
extern  NSString* NSStringFromCurrentDate(void);
extern  NSString* NSStringFromBirthDate(NSDate* birthDate);
extern  NSString* NSImageNameStringFromCurrentDate(void);
extern  NSString* NSStringWithMergeofString(NSString* first,NSString* last);
extern  NSString* NSStringFullname(NSDictionary* aDict);
extern  void showAletViewWithMessage(NSString* msg);
extern  NSString* AgoStringFromTime(NSDate* dateTime);
extern NSString* NSStringFromExpiryDate(NSString* expDate);
extern void showAlertViewMessageTitle(NSString* msg,NSString* title);
extern NSString *formattedStringFromTimeInterval(NSTimeInterval interval);


extern NSString* DocumentDirectoryPath();

extern NSString *getIPAddress();
extern NSString *convertToreadableDateFormat(NSString *dateStr);
extern NSString *convertToreadableFullDateFormat(NSString *dateStr);
extern void showErrorMessageForError(NSString *errorCode);
extern BOOL CheckErrorWithCode(NSString *code);



 
