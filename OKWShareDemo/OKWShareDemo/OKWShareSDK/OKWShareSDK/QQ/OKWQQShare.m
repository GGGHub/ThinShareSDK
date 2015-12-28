//
//  OKWQQShare.m
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/24.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "OKWQQShare.h"
#import "OKWShareDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>

@interface OKWQQShare ()
@property (nonatomic, strong)TencentOAuth *oauth;
@end
@implementation OKWQQShare
+(instancetype)shareInstance
{
    static OKWQQShare *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
        shareInstance.oauth = [[TencentOAuth alloc] initWithAppId:QQ_APP_KEY andDelegate:[OKWShareSDK shareDelegate]];
    });
    return shareInstance;
}
#pragma mark - Send Link
+(void)sendLinkMessage:(OKWShareContent *)content messageType:(OKWShareType)type
{
    if (![TencentOAuth iphoneQQInstalled]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未安装手机QQ" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    switch (type) {
        case OKWShareTypeQQ:
            [[OKWQQShare shareInstance] sendLinkMessageToQQ:content];
            break;
        case OKWShareTypeQQSpace:
            [[OKWQQShare shareInstance] sendLinkMessageToQQSpace:content];
            break;
        default:
            break;
    }
    
}
-(void)sendLinkMessageToQQ:(OKWShareContent *)content
{
    QQApiNewsObject *new=[QQApiNewsObject objectWithURL:[NSURL URLWithString:content.webpageUrl] title:content.title description:content.description previewImageData:content.thumbImageData];
    new.cflag = kQQAPICtrlFlagQQShare;
    SendMessageToQQReq * req = [SendMessageToQQReq  reqWithContent:new];
    NSInteger QQApiSendResultCode = [QQApiInterface sendReq:req];
    NSLog(@"state--%d",QQApiSendResultCode);
    
}
-(void)sendLinkMessageToQQSpace:(OKWShareContent *)content
{
    QQApiNewsObject * new=[QQApiNewsObject objectWithURL:[NSURL URLWithString:content.webpageUrl] title:content.title description:content.description previewImageData:content.thumbImageData];
    new.cflag=kQQAPICtrlFlagQZoneShareOnStart;
    SendMessageToQQReq * req = [SendMessageToQQReq  reqWithContent:new];
    [QQApiInterface sendReq:req];
}
#pragma mark - Send Text
+(void)sendTextMessage:(OKWShareContent *)content messageType:(OKWShareType)type
{
    switch (type) {
        case OKWShareTypeQQ:
            [[OKWQQShare shareInstance] sendTextMessageToQQ:content];
            break;
        case OKWShareTypeQQSpace:
            [[OKWQQShare shareInstance] sendTextMessageToQQSpace:content];
            break;
        default:
            break;
    }
}
-(void)sendTextMessageToQQSpace:(OKWShareContent *)content
{
    QQApiImageArrayForQZoneObject *txtObj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:nil title:content.text];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:txtObj];
   [QQApiInterface sendReq:req];

}
-(void)sendTextMessageToQQ:(OKWShareContent *)content
{
    QQApiTextObject * textObj = [QQApiTextObject objectWithText:content.text];
    
    SendMessageToQQReq * req = [SendMessageToQQReq reqWithContent:textObj];
    
    textObj.cflag = kQQAPICtrlFlagQQShare;
    
    [QQApiInterface sendReq:req];

}
@end
