//
//  AppDelegate.m
//  JustItMind
//
//  Created by Viksah on 9/24/15.
//  Copyright (c) 2015 Viksah Kumar. All rights reserved.
//

#import "AppDelegate.h"
#import "JIMContainerVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self directLogin];
    [self setDateFormator];
    [self registerForPushNotifications];
    return YES;
}

- (void)registerForPushNotifications {
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if(ver >= 8 && ver<9)
    {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            
        }
    }else if (ver >=9){
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        //iOS6 and iOS7 specific code
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert];
    }
}

- (void)setDateFormator {
    _serverFormatter = [[NSDateFormatter alloc]init];
    [_serverFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [_serverFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    
    _localFormattor = [[NSDateFormatter alloc]init];
    [_localFormattor setTimeZone:[NSTimeZone systemTimeZone]];
    [_localFormattor setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
}
- (void)directLogin {
    if([UserDefault objectForKey:@"loginUser"]) {
        self.isDirectLogin = YES;
        me = [[User alloc]init];
        [me setInfo:[UserDefault objectForKey:@"loginUser"]];
        UINavigationController *nav = (id)self.window.rootViewController;
        UIViewController *regVC = [nav.storyboard instantiateViewControllerWithIdentifier:@"SBIDRegVC"];
        JIMContainerVC *containerVC = [nav.storyboard instantiateViewControllerWithIdentifier:@"SBIDContainerVC"];
        [containerVC.tabbarController setSelectedIndex:1];
        nav.viewControllers = @[regVC, containerVC];
    }
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *strToken = [[NSString alloc]initWithData:deviceToken encoding: NSUTF8StringEncoding];
    NSLog(@"Device Token : %@", strToken);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
