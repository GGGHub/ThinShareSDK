//
//  OKWShareSDK.h
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/18.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,OKWShareType) {
    OKWShareTypeWeChatSession = 1000, //微信好友
    OKWShareTypeWeChatTimeLine, //微信朋友圈
    OKWShareTypeWeChatFav,  //微信收藏
    OKWShareTypeQQ, //QQ
    OKWShareTypeQQSpace, //QQ空间
    OKWShareTypeMail,   //邮件
    OKWShareTypeSMS     //短信
};
@interface OKWShareSDK : NSObject

/**
 *  生成要分享种类的数组
 *
 *  @param shareType OKWShareType类型多个参数
 *
 *  @return 返回OKWShareType类型的数组
 */
+(NSArray *)getShareListType:(OKWShareType)shareType,...NS_REQUIRES_NIL_TERMINATION;

/**
 *  默认分享菜单
 *
 *  @param menuTitle 菜单标题
 *  @param model     创建的数据模型，模型由webContentTitle函数生成
 */
+(void)defaultShareMenu:(NSString *)menuTitle model:(id)model;
/**
 *  可选默认分享菜单
 *
 *  @param menuTitle 菜单标题
 *  @param model     创建的数据模型，模型由webContentTitle函数生成
 *  @param types     分享类型数组，数组由getShareListType函数生成
 */
+(void)defaultOptionShareMenu:(NSString *)menuTitle model:(id)model types:(NSArray *)types;
/**
 *  调用分享接口
 *
 *  @param type  分享类型
 *  @param model 分享的数据模型
 */
+(void)share:(OKWShareType)type model:(id)model;
/**
 *  创建分享web的内容
 *
 *  @param title         分享的链接
 *  @param description   分享的描述
 *  @param pageUrl       分享的URL
 *  @param thumbImageData 分享的缩略图
 *
 *  @return 分享的数据模型
 */
+(id)webContentTitle:(NSString *)title description:(NSString *)description webpageUrl:(NSString *)pageUrl thumbImageData:(NSData *)thumbImageData;
/**
 *  创建分享文本内容
 *
 *  @param content 分享的内容
 *
 *  @return 分享的数据模型
 */
+(id)textContent:(NSString *)content;
/**
 *  获取分享代理对象
 */
+(id)shareDelegate;
@end



