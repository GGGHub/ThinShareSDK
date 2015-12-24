//
//  ViewController.m
//  OKWShareDemo
//
//  Created by Labanotation on 15/12/18.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "ViewController.h"
#import "OKWShareSDK/OKWShareSDK.h"
#import "OKWWeChatShare.h"
#import "OKWShareActionSheet.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click:(id)sender {
//    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg"]]];
//    NSData * compressImageData = nil;
//    NSInteger maxData = 1024 * 31;   //最高上传 300K
//    
//    @autoreleasepool {
//        compressImageData  = UIImageJPEGRepresentation(image,1);
//        NSLog(@"Data size : %lf  -  %lu",compressImageData.length / 1024.0,(unsigned long)compressImageData.length);
//        
//        //        NSLog(@"压缩前:%lu",[compressImageData length] / 1024);
//        CGFloat compression = 1.0f;
//        CGFloat maxCompression = 0.3f;
//        while ([compressImageData length] > maxData && compression > maxCompression)
//        {
//            compression -= 0.05;
//            compressImageData = UIImageJPEGRepresentation(image, compression);
//        }
//        if (compressImageData.length > maxData) {
//            CGFloat compressionQuality = (CGFloat)maxData/compressImageData.length;
//            compressImageData  = UIImageJPEGRepresentation(image, compressionQuality);
//        }
//    }
    id model = [OKWShareSDK webContentTitle:@"分享链接" description:@"测试分享" webpageUrl:@"www.baidu.com" thumbImageData:nil];

    [OKWShareSDK defaultShareMenu:@"title" model:model];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
