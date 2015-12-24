//
//  OKWBaseShare.h
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/24.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKWShareSDK.h"
#import "OKWShareContent.h"
@interface OKWBaseShare : NSObject
/**
 *  发送链接消息
 *
 *  @param content 内容
 *  @param type    消息种类
 */
+(void)sendLinkMessage:(OKWShareContent *)content messageType:(OKWShareType)type;

@end
