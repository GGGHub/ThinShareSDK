ThinShareSDK
===
精简版分享框架，可扩展性强，自由定制界面，该框架是静态库文件可以直接拖拽到工程使用也可以打包成`.a`文件使用<br>
已经集成`QQ好友`，`QQ空间`，`微信好友`，`微信朋友圈`，`微信收藏`，`系统短信`，`系统邮件`的链接与文本分享<br>
默认分享界面适配不同的苹果设备

---

##安装
1. 把`OKWShareSDK`整个项目放在要使用工程的文件夹内下，并把`OKWShareSDK.xcodeproj`，拖拽到该工程目录面板中，创建一个`workSpace`。<br>
2. 添加资源文件`OKWShareResource.bundle`到主工程中，里面包含创建界面所需要的图标，因为已经集成了`QQ`，`微信`，与`系统分享`所以需要添加下面的`Framework`与`静态库文件`<br>
![](https://raw.githubusercontent.com/GGGHub/ThinShareSDK/master/OKWShareDemo/01.png)<br>

3. 在`Build Settings`选择项卡中设置`Search Paths`<br>
![](http://img.blog.csdn.net/20151225175435456)
4. 设置`OKWShareSDK-Prefix`中的`WEIXIN_APP_KEY`与`QQ_APP_KEY`
5.  关于`info.plist`修改与其他设置参考Demo

---
##使用
**注意**
**使用前请设置微信与QQ的AppKey，否则无法分享，由于涉及隐私所以Demo里面没有设置微信与QQ的AppKey**<br>
使用默认菜单分享链接
```objective-c
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img05.tooopen.com/images/20150830/tooopen_sy_140703593676.jpg"]];
    
    id model = [OKWShareSDK webContentTitle:@"分享链接" description:@"测试分享" webpageUrl:@"www.baidu.com" thumbImageData:data];   //构建Model
    [OKWShareSDK defaultShareMenu:@"title" model:model];    //使用默认菜单分享
```
效果<br>
![](http://img.blog.csdn.net/20151225180921424)<br>

---
选择分享类型分享
```objective-c
    //分享链接
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://i1.ce.cn/ce/life/xxsh/dwyd/200909/22/W020090922351057588500.jpg"]];
    
    id model = [OKWShareSDK webContentTitle:@"分享链接" description:@"测试分享" webpageUrl:@"www.baidu.com" thumbImageData:data];   //构建Model
    
    NSArray *typeArray = [OKWShareSDK getShareListType:OKWShareTypeQQ,OKWShareTypeWeChatFav,OKWShareTypeSMS ,nil];  //构建分享类型
    
    [OKWShareSDK defaultOptionShareMenu:@"title" model:model types:typeArray];
```
效果<br>
![](http://img.blog.csdn.net/20151225181425442)

---
分享文本
```objective-c
    id model = [OKWShareSDK textContent:@"分享文本信息"]; //构建Model
    [OKWShareSDK defaultShareMenu:@"title" model:model];
```

#关于扩展与源码说明请参考[我的博客](http://blog.csdn.net/GGGHub/article/details/50404590)<br>
#QQ:358812735



