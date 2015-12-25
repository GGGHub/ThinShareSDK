//
//  AppDelegate.m
//  OKWShareDemo
//
//  Created by Labanotation on 15/12/18.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "AppDelegate.h"
#import "OKWShareSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#define WEIXIN_APP_KEY        @"wxae9c0539569e888b"
#define WEIXIN_AppSecret      @"20b8691232ff0595c39660f06b5a7dd9"
#define QQ_APP_KEY  @"tencent1104783662"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url scheme] isEqualToString:WEIXIN_APP_KEY]) {
        return [WXApi handleOpenURL:url delegate:[OKWShareSDK shareDelegate]];
    }
    if ([[url scheme] isEqualToString:QQ_APP_KEY]) {
        return  [QQApiInterface handleOpenURL:url delegate:[OKWShareSDK shareDelegate]];
    }
    return YES;
    
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url scheme] isEqualToString:WEIXIN_APP_KEY]) {
        return [WXApi handleOpenURL:url delegate:[OKWShareSDK shareDelegate]];
    }
    if ([[url scheme] isEqualToString:QQ_APP_KEY]) {
        return  [QQApiInterface handleOpenURL:url delegate:[OKWShareSDK shareDelegate]];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:WEIXIN_APP_KEY];
    
    
    return YES;
}



@end
