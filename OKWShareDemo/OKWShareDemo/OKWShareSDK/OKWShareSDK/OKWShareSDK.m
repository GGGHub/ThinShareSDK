//
//  OKWShareSDK.m
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/18.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "OKWShareSDK.h"
#import "OKWShareContent.h"
#import "OKWShareActionSheet.h"
#import "OKWWeChatShare.h"
#import "OKWBaseShare.h"
#import "OKWShareDelegate.h"
@interface NSDictionary (defaultShareData)
+(id)defaultShareData;
@end

@implementation OKWShareSDK


+(NSArray *)getShareListType:(OKWShareType)shareType,...
{
    NSMutableArray *shareTypeArray = [NSMutableArray new];
    [shareTypeArray addObject:[NSNumber numberWithInteger:shareType]];
    va_list args;
    va_start(args, shareType);
    while (1) {
        NSInteger type = va_arg(args, OKWShareType);
        if (!type) {
            break;
        }
        [shareTypeArray addObject:[NSNumber numberWithInteger:type]];
    }
    va_end(args);
    return [shareTypeArray copy];
}
+(id)webContentTitle:(NSString *)title description:(NSString *)description webpageUrl:(NSString *)pageUrl thumbImageData:(NSData *)thumbImageData
{
    OKWShareContent *shareContent = [OKWShareContent new];
    shareContent.title = title;
    shareContent.description = description;
    shareContent.webpageUrl = pageUrl;
    shareContent.thumbImageData = thumbImageData;
    return shareContent;
    
}
+(void)defaultShareMenu:(NSString *)menuTitle model:(id)model
{
    [OKWShareSDK defaultOptionShareMenu:menuTitle model:model types:[OKWShareSDK getShareListType:OKWShareTypeWeChatSession,OKWShareTypeWeChatTimeLine,OKWShareTypeWeChatFav,OKWShareTypeQQ,OKWShareTypeQQSpace,OKWShareTypeMail,OKWShareTypeSMS,nil]];
}
+(void)defaultOptionShareMenu:(NSString *)menuTitle model:(id)model types:(NSArray *)types
{
    NSDictionary *shareData = [NSDictionary defaultShareData];
    [[UIApplication sharedApplication].delegate window];
    OKWShareActionSheet *actionSheet = [[OKWShareActionSheet alloc] initWithTitle:menuTitle];
    [types enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       [actionSheet addButtonWithTitle:shareData[obj][@"title"] image:[UIImage imageNamed:shareData[obj][@"image"]] handle:^{
           [OKWShareSDK shareLink:[obj unsignedIntValue] model:model];
       }];
    }];
    [actionSheet showInView:[[UIApplication sharedApplication].delegate window]];
}
+(void)shareLink:(OKWShareType)type model:(id)model
{
    [OKWBaseShare sendLinkMessage:model messageType:type];
}
+(id)shareDelegate
{
    return [OKWShareDelegate shareInstance];
}
@end

@implementation NSDictionary (defaultShareData)
+(id)defaultShareData;
{
    NSMutableDictionary *shareData = [NSMutableDictionary new];
    
    NSDictionary *weChatSession = @{@"image":@"OKWShareResource.bundle/wechat_friends",@"title":@"微信好友"};
    [shareData addEntriesFromDictionary:@{[NSNumber numberWithUnsignedInteger:OKWShareTypeWeChatSession]:weChatSession}];
    
    NSDictionary *weChatTimeLine = @{@"image":@"OKWShareResource.bundle/wechant_timeline",@"title":@"朋友圈"};
    [shareData addEntriesFromDictionary:@{[NSNumber numberWithUnsignedInteger:OKWShareTypeWeChatTimeLine]:weChatTimeLine}];
    
    NSDictionary *weChatFav = @{@"image":@"OKWShareResource.bundle/wechat_fav",@"title":@"微信收藏"};
    [shareData addEntriesFromDictionary:@{[NSNumber numberWithUnsignedInteger:OKWShareTypeWeChatFav]:weChatFav}];
    
    NSDictionary *QQ = @{@"image":@"OKWShareResource.bundle/qq_friends",@"title":@"QQ好友"};
    [shareData addEntriesFromDictionary:@{[NSNumber numberWithUnsignedInteger:OKWShareTypeQQ]:QQ}];
    
    NSDictionary *QQSpace = @{@"image":@"OKWShareResource.bundle/qq_space",@"title":@"QQ空间"};
    [shareData addEntriesFromDictionary:@{[NSNumber numberWithUnsignedInteger:OKWShareTypeQQSpace]:QQSpace}];
    
    NSDictionary *mail = @{@"image":@"OKWShareResource.bundle/mail",@"title":@"邮件"};
    [shareData addEntriesFromDictionary:@{[NSNumber numberWithUnsignedInteger:OKWShareTypeMail]:mail}];
    
    NSDictionary *SMS = @{@"image":@"OKWShareResource.bundle/message",@"title":@"短信"};
    [shareData addEntriesFromDictionary:@{[NSNumber numberWithUnsignedInteger:OKWShareTypeSMS]:SMS}];
    
    return shareData;
}
@end

