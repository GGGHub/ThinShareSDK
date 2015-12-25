//
//  OKWSystemShare.m
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/24.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "OKWSystemShare.h"
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "OKWShareDelegate.h"
@implementation OKWSystemShare
#pragma mark - Send Link
+(void)sendLinkMessage:(OKWShareContent *)content messageType:(OKWShareType)type
{
    switch (type) {
        case OKWShareTypeSMS:
            [OKWSystemShare sendLinkMessageToSMS:content];
            break;
        case OKWShareTypeMail:
            [OKWSystemShare sendLinkMessageToMail:content];
            break;
        default:
            break;
    }
}


+(void)sendLinkMessageToSMS:(OKWShareContent *)content
{
    //if can send message
    if([MFMessageComposeViewController canSendText]){
        MFMessageComposeViewController *messageController=[[MFMessageComposeViewController alloc]init];
        
        //set delegate
        messageController.messageComposeDelegate=[OKWShareDelegate shareInstance];
        
        //if supply subject
        if([MFMessageComposeViewController canSendSubject]){
            messageController.subject=content.title;
        }
        
        //message body
        NSString *body = [NSString stringWithFormat:@"%@%@",[content.description isKindOfClass:[NSString class]]?content.description:@"",[content.webpageUrl isKindOfClass:[NSString class]]?content.webpageUrl:@""];
        messageController.body=body;
        [[OKWSystemShare getCurrentVC] presentViewController:messageController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持发送短信" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}
+(void)sendLinkMessageToMail:(OKWShareContent *)content
{
    //if can send mail
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailController=[[MFMailComposeViewController alloc]init];
        mailController.mailComposeDelegate=[OKWShareDelegate shareInstance];
        
        //set object
        [mailController setSubject:content.title];
        
        //set content
         NSString *body = [NSString stringWithFormat:@"%@%@",[content.description isKindOfClass:[NSString class]]?content.description:@"",[content.webpageUrl isKindOfClass:[NSString class]]?content.webpageUrl:@""];
        [mailController setMessageBody:body isHTML:YES];
        
        //获取当前时间，日期
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        //添加附件
        [mailController addAttachmentData:content.thumbImageData mimeType:@"image/jpeg" fileName:dateString];//第二个参数是mimeType类型，jpg图片对应image/jpeg
        
        [[OKWSystemShare getCurrentVC] presentViewController:mailController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持发送邮件" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
#pragma mark - Send Text
+(void)sendTextMessage:(OKWShareContent *)content messageType:(OKWShareType)type
{
    switch (type) {
        case OKWShareTypeSMS:
            [OKWSystemShare sendTextMessageToSMS:content];
            break;
        case OKWShareTypeMail:
            [OKWSystemShare sendTextMessageToMail:content];
            break;
        default:
            break;
    }
}
+(void)sendTextMessageToSMS:(OKWShareContent *)content
{
    if([MFMessageComposeViewController canSendText]){
        MFMessageComposeViewController *messageController=[[MFMessageComposeViewController alloc]init];
        
        //set delegate
        messageController.messageComposeDelegate=[OKWShareDelegate shareInstance];

        //message body
        NSString *body = content.text;
        messageController.body=body;
        [[OKWSystemShare getCurrentVC] presentViewController:messageController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持发送短信" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
+(void)sendTextMessageToMail:(OKWShareContent *)content
{
    //if can send mail
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailController=[[MFMailComposeViewController alloc]init];
        mailController.mailComposeDelegate=[OKWShareDelegate shareInstance];
        //set content
        NSString *body = content.text;
        [mailController setMessageBody:body isHTML:YES];
        
        [[OKWSystemShare getCurrentVC] presentViewController:mailController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持发送邮件" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
#pragma mark - Current View Controller
+(UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return [self currentVCWithVC:result];
}


+(UIViewController *)currentVCWithVC:(UIViewController *)vc{
    if([vc isKindOfClass:[UITabBarController class]]){
        return [self currentVCWithVC:((UITabBarController *)vc).selectedViewController];
    }
    
    if([vc isKindOfClass:[UINavigationController class]]){
        return [self currentVCWithVC:((UINavigationController *)vc).visibleViewController];
    }
    
    return vc;
}
@end
