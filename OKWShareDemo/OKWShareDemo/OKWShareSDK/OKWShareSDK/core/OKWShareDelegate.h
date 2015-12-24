//
//  OKWShareDelegate.h
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/24.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
@interface OKWShareDelegate : NSObject <MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

+(instancetype)shareInstance;

@end
