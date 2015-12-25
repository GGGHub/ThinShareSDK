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

    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img05.tooopen.com/images/20150830/tooopen_sy_140703593676.jpg"]];
    
    id model = [OKWShareSDK webContentTitle:@"分享链接" description:@"测试分享" webpageUrl:@"www.baidu.com" thumbImageData:data];

    id textModel = [OKWShareSDK textContent:@"分享链接分享链接分享链接分享链接分享链接分享链接分享链接分享链接分享链接"];
    [OKWShareSDK defaultShareMenu:@"title" model:textModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
