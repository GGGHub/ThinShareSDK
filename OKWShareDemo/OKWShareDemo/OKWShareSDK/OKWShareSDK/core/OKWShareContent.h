//
//  OKWShareContent.h
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/21.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface OKWShareContent : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *description;
@property (nonatomic,copy) NSString *webpageUrl;
@property (nonatomic,copy) NSData *thumbImageData;

@end
