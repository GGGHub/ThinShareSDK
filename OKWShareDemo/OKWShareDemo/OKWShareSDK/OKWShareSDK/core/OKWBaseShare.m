//
//  OKWBaseShare.m
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/24.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "OKWBaseShare.h"
#import "OKWWeChatShare.h"
#import "OKWQQShare.h"
#import "OKWSystemShare.h"
#import "OKWUtility.h"
@implementation OKWBaseShare
+(void)sendLinkMessage:(OKWShareContent *)content messageType:(OKWShareType)type
{
    /**
     压缩图片大小
     */
    content.thumbImageData = [OKWUtility compressData:content.thumbImageData length:1024*30];
    
    NSLog(@"%.2f",content.thumbImageData.length/1024.0);
    switch (type) {
        case OKWShareTypeWeChatFav:
        case OKWShareTypeWeChatTimeLine:
        case OKWShareTypeWeChatSession:
            [OKWWeChatShare sendLinkMessage:content messageType:type];
            break;
        case OKWShareTypeMail:
        case OKWShareTypeSMS:
            [OKWSystemShare sendLinkMessage:content messageType:type];
            break;
        case OKWShareTypeQQ:
        case OKWShareTypeQQSpace:
            [OKWQQShare sendLinkMessage:content messageType:type];
            break;
        default:
            break;
    }
}
+(void)sendTextMessage:(OKWShareContent *)content messageType:(OKWShareType)type
{
    switch (type) {
        case OKWShareTypeWeChatFav:
        case OKWShareTypeWeChatTimeLine:
        case OKWShareTypeWeChatSession:
            [OKWWeChatShare sendTextMessage:content messageType:type];
            break;
        case OKWShareTypeMail:
        case OKWShareTypeSMS:
            [OKWSystemShare sendTextMessage:content messageType:type];
            break;
        case OKWShareTypeQQ:
        case OKWShareTypeQQSpace:
            [OKWQQShare sendTextMessage:content messageType:type];
            break;
        default:
            break;
    }
}
@end
