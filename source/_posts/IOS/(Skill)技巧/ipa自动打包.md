---
title: Python实现iOS自动化打包详解
date: 2018-05-08 11:45:05
tags: autoPack
---


可能是最简单的iOS自动化打包方式:无需手动配置证书,无需填写配置文件名称,更无需配置Bundle Identifer,总之无需很多繁琐配置,让打包流程一句命令完成!下面将会分享两种打包方式,一种是快速打包(打包时间就在一眨眼),一种是基于shenzhen（速度会比较慢）,都实现了一行命令完成打包并上传蒲公英！


**注意:**

1. iOS自动化打包脚本:[https://github.com/ys323945/iOSAutoPage/tree/master](https://github.com/ys323945/iOSAutoPage/tree/master)
2. AppStore的包,还是建议使用**Xcode打包**。


# Python实现iOS自动化打包详解

## 基于编译的打包

这种打包方式应该是目前所有打包方式中最快的，就是编译工程--找到.app文件--新建Payload文件夹--拷贝.app到Payload文件夹--压缩成zip--更改后缀名为ipa--完成！


### 演示过程如下图


![](/images/ipa/默认打包流程.gif)


### 过程自动化

**注意:**输入日志描述只能输入**数字**,非数字会报错。

![](/images/ipa/过程自动化.gif)

在上图中,我们只需要执行python脚本,可以看到桌面很快生成了一个ProgramBag的文件夹,打开文件夹,彩蛋就在里面了!由于我写的脚本里包含了上传蒲公英的代码,网络不太好会影响上传时间,真正的打包时间是可以忽略不记的,也就是执行脚本,敲击回车就好了的事!


这里我们将打好的包自动上传到蒲公英网站,完成后自动打开下载地址,这个过程在网络好的条件下2分钟左右完成,99.9%的时间是发在上传包上!这里上传完成会自动打开到下载的网页。

### 原理实现

**Python的具体代码:**


```
	#!/usr/bin/env python
	#coding=utf-8 
	import os
	import commands
	import requests
	import webbrowser
	
	'''
	使用注意事项:该脚本基于python3.6.5
	1、将工程的编译设备选成 Gemeric iOS Device
	2、command + B编译
	3、执行脚本文件
	
	'''
	
	appFileFullPath = '/Users/wubin/Library/Developer/Xcode/DerivedData/FotileStyle-doiplszeqpeztmcrysurltpnhepy/Build/Products/Debug-iphonesimulator/FotileStyle.app'
	PayLoadPath = '/Users/wubin/Desktop/Payload'
	packBagPath = '/Users/wubin/Desktop/ProgramBag'
	
	#将此处打开的链接改为蒲公英对应app的链接
	openUrl = 'https://www.pgyer.com/manager/dashboard/app/40c633aa8dc0ba15191632860558825e'
	
	#上传蒲公英
	USER_KEY = "b3a0b9*******************ed6fb2"
	API_KEY = "1fda5e1*******************a95737"
	
	#上传蒲公英
	def uploadIPA(IPAPath):
	    if(IPAPath==''):
	        print "\n*************** 没有找到对应上传的IPA包 *********************\n"
	        return
	    else:
	        print "\n***************开始上传到蒲公英*********************\n"
	        url='http://www.pgyer.com/apiv1/app/upload'
	        data={
	            'uKey':USER_KEY,
	            '_api_key':API_KEY,
	            'installType':'2',
	            'password':'',
	            'updateDescription':des
	        }
	        files={'file':open(IPAPath,'rb')}
	        r=requests.post(url,data=data,files=files)
	
	def openDownloadUrl():
	    webbrowser.open(openUrl,new=1,autoraise=True)
	    print "\n*************** 更新成功 *********************\n"
	
	#编译打包流程
	def bulidIPA():
	    #打包之前先删除packBagPath下的文件夹
	    commands.getoutput('rm -rf %s'%packBagPath)
	    #创建PayLoad文件夹
	    mkdir(PayLoadPath)
	    #将app拷贝到PayLoadPath路径下
	    commands.getoutput('cp -r %s %s'%(appFileFullPath,PayLoadPath))
	    #在桌面上创建packBagPath的文件夹
	    commands.getoutput('mkdir -p %s'%packBagPath)
	    #将PayLoadPath文件夹拷贝到packBagPath文件夹下
	    commands.getoutput('cp -r %s %s'%(PayLoadPath,packBagPath))
	    #删除桌面的PayLoadPath文件夹
	    commands.getoutput('rm -rf %s'%(PayLoadPath))
	    #切换到当前目录
	    os.chdir(packBagPath)
	    #压缩packBagPath文件夹下的PayLoadPath文件夹夹
	    commands.getoutput('zip -r ./Payload.zip .')
	    print "\n*************** 打包成功 *********************\n"
	    #将zip文件改名为ipa
	    commands.getoutput('mv Payload.zip Payload.ipa')
	    #删除payLoad文件夹
	    commands.getoutput('rm -rf ./Payload')
	
	
	#创建PayLoad文件夹
	def mkdir(PayLoadPath):
	    isExists = os.path.exists(PayLoadPath)
	    if not isExists:
	        os.makedirs(PayLoadPath)
	        print PayLoadPath + '创建成功'
	        return True
	    else:
	        print PayLoadPath + '目录已经存在'
	        return False
	
	
	if __name__ == '__main__':
	    des = input("请输入更新的日志描述:")
	    bulidIPA()
	    uploadIPA('%s/Payload.ipa'%packBagPath)
	    openDownloadUrl()
```

**def bulidIPA():**其实就是liunx命令,通过脚本包装了一层,可以理解为我们以前在terminal手动输入的命令,现在是自动帮我们输入并执行了,大大解放了我们的双手!


```
	#打包之前先删除packBagPath下的文件夹
	commands.getoutput('rm -rf %s'%packBagPath)
```

分析上面这一句,我用OC的伪代码来实现的话对应下面这句:所以上面的%s相当于OC中的%@,代表一种格式符,后面的appFileFullPath代表我们工程的.app存放的路径,PayLoadPath代表我们在桌面上新建的PayLoad文件路径

```
	copy("%@,%@",A,B)
```

结合注释基本上代码的执行过程我们就一目了然了,至于前面的commands.getoutput是基于commands组件的命令,理解为可以在terminal执行命令即可,下面有一句代码需要说明:这是一句切换当前目录的命令

```
	os.chdir(packBagPath)
```

等价于

```
	commands.getoutput('cd %s'%packBagPath)
```

不要问我为什么没有用下面的命令,那是因为这句命令我这边执行不成功,被坑了很久,至于原因,还不知道为什么(如果你解决了,欢迎骚扰我),所以用上面python提供的命令代替了。

###  上传蒲公英脚本

```
	def uploadIPA(IPAPath):
	表示定义了一个函数uploadIPA，接受一个参数
```


requests是一个网络请求的组件,我们可以把它类比为AFNetWorking,data是要传递的参数,files是要传递的文件,至于上传的参数key都是根据蒲公英提供的API来写的。上面的password代表安装app时所需要的密码,同时还有两个参数,USER_KEY和API_KEY,在蒲公英应用的位置可以找到,如图:

![](/images/ipa/蒲公英.jpg)


```
	def openDownloadUrl():
	webbrowser.open(openUrl,new=1,autoraise=True)
	print "\n*************** 更新成功 *********************\n"
```


webbrowser也是**一个组件库**,这些组件库在使用时,和OC一样**都要先import**里面的地址代表蒲公英上应用的地址,拷过来粘贴即可!



###  配置永久参数

```
	appFileFullPath = '/Users/wubin/Library/Developer/Xcode/DerivedData/FotileStyle-doiplszeqpeztmcrysurltpnhepy/Build/Products/Debug-iphonesimulator/FotileStyle.app'
	PayLoadPath = '/Users/wubin/Desktop/Payload'
	packBagPath = '/Users/wubin/Desktop/ProgramBag'
	
	#将此处打开的链接改为蒲公英对应app的链接
	openUrl = 'https://www.pgyer.com/manager/dashboard/app/40c633aa8dc0ba15191632860558825e'
	
	#上传蒲公英
	USER_KEY = "b3a0b9*******************ed6fb2"
	API_KEY = "1fda5e1*******************a95737"
```
上图中**appFileFullPath**就是我们工程文件中.app的地址,至于**PayLoadPath和packBagPath**只需要你将**wubin**用户名修改为**你自己电脑的用户名**即可!


## shenzhen打包

**shenzhen**是一个打包相关的库,使用也非常方便,比第一中打包方式还要少一个路径配置,当然打包的速度相对比较慢,要使用下面的脚本,首先得安装shenzhen[链接](https://github.com/nomad/shenzhen)。

```
	 #!/usr/bin/env python
#coding=utf-8 
import os,time
#import commands
import subprocess
import requests
import webbrowser
import time

#上传蒲公英
USER_KEY = "b3a0b950c29d1d081aaf6a0ba6ed6fb2"
API_KEY = "1fda5e1404ddb402d7e7c186d0a95737"

def searchIpaPath():
    IpaPath=""
    for i in os.listdir("."):
        if(i.find('.ipa')!=(-1)):
            IpaPath=i
            print '找到的IPA文件:'+IpaPath
            return IpaPath
    return IpaPath

def uploadIPA(IPAPath):
    if(IPAPath==''):
        print "\n*************** 没有找到对应上传的IPA包 *********************\n"
        return
    else:
        print "\n***************开始上传到蒲公英*********************\n"
        url='http://www.pgyer.com/apiv1/app/upload'
        data={
            'uKey':USER_KEY,
            '_api_key':API_KEY,
            'installType':'2',
            'password':'',
            'updateDescription':des
            }
        files={'file':open(IPAPath,'rb')}
        r=requests.post(url,data=data,files=files)


def openDownloadUrl():
    #此处的地址需要换成蒲公英上自己对应的应用地址
    webbrowser.open(r'https://www.pgyer.com/manager/dashboard/app/40c633aa8dc0ba15191632860558825e',new=1,autoraise=True)
    print "\n*************** 更新成功 *********************\n"

def buildIpa():
    start = time.time()
    print "\n*************** IPA包生成中 *********************\n"
     #commands.getoutput('ipa build')  #使用shenzheng打包ipa
    p = subprocess.Popen('ipa build', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in p.stdout.readlines():
        print line,
    retval = p.wait()

    end = time.time()
    print "--------- 打包耗时:%s秒 ---------"%(end-start)
    print "\n*************** IPA包生成成功，准备上传蒲公英 *********************\n"


if __name__ == '__main__':
    #输入日志格式为 "修改bug" 记得加上双引号，如果有多行可以这么写:
    # "1 修改首页bug  \n  2 修改点击按钮闪退问题 "
    des = input("请输入更新的日志描述:")
    buildIpa()
    IpaPath=searchIpaPath()
    uploadIPA(IpaPath)
    openDownloadUrl()
    
```
这里我主要是将**shenzhen**的打包命令"ipa build"封装在pythone脚本中,同时记录了打包的时间,经过测试打包的时间在4 ~ 7分钟左右,这个脚本中只需要配置蒲公英的USER_KEY和API_KEY,然后cd到当前工程目录,执行脚本即可!打包成功会在当前工程目录下生成ipa包和符号化文件!使用如下:

![](/images/ipa/shenzhen自动化.gif)


[转载原文:](http://www.cocoachina.com/ios/20180507/23295.html)


