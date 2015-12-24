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
@implementation OKWBaseShare
+(void)sendLinkMessage:(OKWShareContent *)content messageType:(OKWShareType)type
{
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
@end
