---
title: 正则表达式
date: 2018-06-08 17:04:25
tags: RegularExpression
---

```
	//string regexstr = @"<[^>]*>";    //去除所有的标签
	//@"<script[^>]*?>.*?</script>" //去除所有脚本，中间部分也删除
	
	// string regexstr = @"<img[^>]*>";  //去除图片的正则
	
	// string regexstr = @"<(?!br).*?>";  //去除所有标签，只剩br
	
	// string regexstr = @"<table[^>]*?>.*?</table>";  //去除table里面的所有内容
	
	//string regexstr = @"<(?!img|br|p|/p).*?>";  //去除所有标签，只剩img,br,p

```


