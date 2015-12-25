//
//  OKWWeChatShare.m
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/21.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "OKWWeChatShare.h"
#import "WXApi.h"
#import "WXApiObject.h"

@implementation OKWWeChatShare
+(BOOL)isWXAppInstalled
{
    return [WXApi isWXAppInstalled];
}
#pragma mark - Send Link
+(void)sendLinkMessage:(OKWShareContent *)content messageType:(OKWShareType)type
{
    switch (type) {
        case OKWShareTypeWeChatFav:
            [OKWWeChatShare sendLinkMessage:content scene:WXSceneFavorite];
            break;
        case OKWShareTypeWeChatSession:
            [OKWWeChatShare sendLinkMessage:content scene:WXSceneSession];
            break;
        case OKWShareTypeWeChatTimeLine:
            [OKWWeChatShare sendLinkMessage:content scene:WXSceneTimeline];
            break;
        default:
            break;
    }
}
+(void)sendLinkMessage:(OKWShareContent *)content scene:(int)scene
{
    
    if (![OKWWeChatShare isWXAppInstalled]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有安装微信" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = content.title;
    message.description = content.description;
    [message setThumbData:content.thumbImageData];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = content.webpageUrl;
    message.mediaObject = ext;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
    
}
#pragma mark - Send Text
+(void)sendTextMessage:(OKWShareContent *)content messageType:(OKWShareType)type
{

    switch (type) {
        case OKWShareTypeWeChatFav:
            [OKWWeChatShare sendTextMessage:content scene:WXSceneFavorite];
            break;
        case OKWShareTypeWeChatSession:
            [OKWWeChatShare sendTextMessage:content scene:WXSceneSession];
            break;
        case OKWShareTypeWeChatTimeLine:
            [OKWWeChatShare sendTextMessage:content scene:WXSceneTimeline];
            break;
        default:
            break;
    }
}
+(void)sendTextMessage:(OKWShareContent *)content scene:(int)scene
{
    if (![OKWWeChatShare isWXAppInstalled]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有安装微信" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = content.text;
    req.bText = YES;
    req.scene = scene;
    
    [WXApi sendReq:req];
}
@end
