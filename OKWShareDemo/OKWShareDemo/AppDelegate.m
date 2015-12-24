//
//  AppDelegate.m
//  OKWShareDemo
//
//  Created by Labanotation on 15/12/18.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "AppDelegate.h"
#define WEIXIN_APP_KEY        @""
#define WEIXIN_AppSecret      @""
#import "OKWShareSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[OKWShareSDK shareDelegate]];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:[OKWShareSDK shareDelegate]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"RegisterApp is %d",[WXApi registerApp:WEIXIN_APP_KEY]);
    return YES;
}



@end
