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

    //分享链接
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://i1.ce.cn/ce/life/xxsh/dwyd/200909/22/W020090922351057588500.jpg"]];
    
    id model = [OKWShareSDK webContentTitle:@"分享链接" description:@"测试分享" webpageUrl:@"www.baidu.com" thumbImageData:data];   //构建Model
    
    NSArray *typeArray = [OKWShareSDK getShareListType:OKWShareTypeQQ,OKWShareTypeWeChatFav,OKWShareTypeSMS ,nil];  //构建分享类型

    [OKWShareSDK defaultOptionShareMenu:@"title" model:model types:typeArray];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
