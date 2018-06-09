---
title: 综合技巧
date: 2018-05-31 19:04:25
tags: IOS
---


![](/images/skill/2107549-ace2e87112e5f97c.jpg)

首先解读下这个错误，意思是说：
TKIMFileMsgView,TKIMVideoMsgView,TKIMToolView这三个文件引用了TKIMUIHelper这个文件，但是找不到TKIMUIHelper这个文件。

先别急，以下几步让你定位并解决这个问题：
1、先确定这个文件有没有
确定方式：1）在工程里面搜索 2）在项目所在的文件夹目录里面搜索
2、如果都搜不到说明这个文件是没有的，找提供文件的人
3、如果搜得到就说明这个文件有只是没引入，引入就好了



**过滤标签内样式**

```
	   htmlString = [htmlString stringByReplacingRegex:@"<p[^>]*>" options:NSRegularExpressionAnchorsMatchLines withString:@"<p>"];
```

**!important;height:auto; 图片自适应**

```
	NSString *htmlString = [NSString stringWithFormat:@"<html> <head> <style>img{width:%f !important;height:auto;} body{font-size:14;color:gray;}</style> </head> <body> %@ </body> </html>",self.viewController.contentView.width - 20.f,[newsDetailModel.content stringByReplacingHTMLEntities]];
   htmlString = [htmlString stringByReplacingRegex:@"<p[^>]*>" options:NSRegularExpressionAnchorsMatchLines withString:@"<p>"];
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    contentLabel.attributedText = attrStr;
```