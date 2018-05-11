---
title: 错误分析
tags: IOS
abbrlink: 11597
date: 2018-02-26 11:17:43
---

# 错误报告

## 友盟错误报告分析

![](/images/dysm/dsym_demo.jpg)


**报告主要内容:**

	1.首行是错误的原因。错误是数组越界。
	2.红色涂层部分就是项目名称
	3.红色涂层之间有一个淡绿色的地址,这就是错误代码的位置。
	4.dysm uuid,这个是DYSM文件的唯一标识。dysm是保存16进制函数地址映射信息的中转文件,我们调式的symbolds都会包含在这个文件中,并且项目每次编译的时候都会产生一个新的dysm文件。
	5.CPU Type CPU 参数
	

## 定位错误的时候,需要xx.app 和 xx.app.DSYM文件
 
 
1. 在Windoes->Organizer->archivers可以看到每一次的打包。然后选择你要查看的错误报告所在的版本.**`这个必须要选对`**

	
![](/images/dysm/xcode_organizer.png)
	
	
![](/images/dysm/xcode_archivers.jpg)
	
	
选择你的错误报告所对应的包,点击右键,然后选择Show in Finder选项,查看这个包中的内容,如图:
	
![](/images/dysm/xcode_finder.jpg)
  
找到包后,右键,选择Show in Finder选项,查看这个包中的内容,如图:
  
![](/images/dysm/xcode_xcarchive.jpg)
  
右键选择要显示的内容,看到了 dSYMs、Products、SCMBlueprint三个文件,如图:
  
![](/images/dysm/xcode_app_dsym.jpg)
  
  
![](/images/dysm/xcode_product_applications.jpg)
  
此时,把这俩个文件取出来,放在一个新的文件中,如图:
  
![](/images/dysm/xcode_crash.jpg)
  
	
2.打开终端 cd 刚才 `crash` 目录下 
 
   输入命令 xcrun atos -arch arm64 -o xxx.app/xxx 0x1000444e8
  
>  启动arm64为CPU Type
>  xxx为工程名,也就是上图片打红色涂层的部分
>  0x1000444e8 为错误代码地址,也就是友盟错误报告淡绿色的部分

 ![](/images/dysm/xcode_result.jpg)



方法 **`[view recursiveDescription]`**  该方法可以当做是Reveal的文字版，用来查看当前页面的布局








