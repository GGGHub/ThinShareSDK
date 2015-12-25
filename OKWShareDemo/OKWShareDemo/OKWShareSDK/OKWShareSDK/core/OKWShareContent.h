//
//  OKWShareContent.h
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/21.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,OKWShareDataType) {
    OKWShareWabURL,
    OKWShareText
};
@interface OKWShareContent : NSObject

@property (nonatomic,copy) NSString *title; //标题
@property (nonatomic,copy) NSString *description;   //描述信息
@property (nonatomic,copy) NSString *webpageUrl;    //wap链接
@property (nonatomic,copy) NSData *thumbImageData;  //缩略图数据
@property (nonatomic) NSString *text;   //文本信息

@property (nonatomic) OKWShareDataType dataType;    //内容类型
@end
