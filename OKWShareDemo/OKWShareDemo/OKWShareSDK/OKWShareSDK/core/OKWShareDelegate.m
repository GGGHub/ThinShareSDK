//
//  OKWShareDelegate.m
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/24.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "OKWShareDelegate.h"
#import "WXApi.h"
#import "WXApiObject.h"
@implementation OKWShareDelegate
+(instancetype)shareInstance
{
    static OKWShareDelegate *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

#pragma mark - WeChat Delegate
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
       //发送消息后回到App后回调
    }
}
#pragma mark - QQ Delegate

#pragma mark - System Message Delegate
//发送完成，不管成功与否
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"发送成功.");
            break;
        case MessageComposeResultCancelled:
            NSLog(@"取消发送.");
            break;
        default:
            NSLog(@"发送失败.");
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Mail Delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    //    [[Tool getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"发送成功.");
            break;
        case MFMailComposeResultSaved://如果存储为草稿（点取消会提示是否存储为草稿，存储后可以到系统邮件应用的对应草稿箱找到）
            NSLog(@"邮件已保存.");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"取消发送.");
            break;
            
        default:
            NSLog(@"发送失败.");
            break;
    }
    if (error) {
        NSLog(@"发送邮件过程中发生错误，错误信息：%@",error.localizedDescription);
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
