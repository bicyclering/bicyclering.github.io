---
title: SDK版本差异
tags: IOS
abbrlink: 42729
date: 2018-03-06 16:40:54
---


# SDK Release Notes(发行说明)

## IOS 2

[iOS 2.2 -> 2010-09-08](https://developer.apple.com/library/content/releasenotes/iPhone/RN-iPhoneSDK/index.html#//apple_ref/doc/uid/TP40007428)

### [Bug Reporting (错误报告)](https://developer.apple.com/library/content/releasenotes/iPhone/RN-iPhoneSDK/index.html#//apple_ref/doc/uid/TP40007428-CH1-DontLinkElementID_1)

请使用Developer Connection网站上的Apple Bug Reporter报告“已知问题”中未提及的任何错误:[http://developer.apple.com/bugreporter/](http://developer.apple.com/bugreporter/)。

* 对于您的应用程序出现的问题，请提供一个示例应用程序，以说明您遇到的问题。
* 在报告任何错误时，请提供您正在使用的操作系统和/或SDK版本以及您正在使用的特定硬件。
* 报告崩溃问题时，请包括任何相关的崩溃日志。与iTunes同步后，可以检索崩溃日志。

	> Macintosh用户可以在 ~/Library/Logs/CrashReporter/MobileDevice/<iPhone name> 找到崩溃日志
	> 	
	> Windows用户可以在Application Data\Apple Computer\Logs\CrashReporter\MobileDevice\<iPhone name> 找到崩溃日志
   
* 如果您发现早期发行版中存在更高版本时存在缺陷，请将您的设备更新至最新版本并确认它仍然存在，因为您的错误可能已在新版本中得到解决。

### Notes of Interest(注意事项)

1.  Media

> SDK现在支持线路输入附件。应用程序将能够在所有设备上接收音频输入。您应该使用该**kAudioSessionProperty_AudioInputAvailable**来确定在任何给定时间音频输入是否可用。	
> 
> 默认情况下，第三方应用程序现在遵守振铃器开关位置。如果即使在振铃器开关处于静音位置时也要播放音频，请使用**AudioSession API**并设置适当的类别。
> 	
> **kAudioSessionCategory_SoloAmbient**是一种尊重铃声开关的新音频会话类别**kAudioSessionCategory_Ambient**。然而,**kAudioSessionCategory_Ambient**混合歌曲不同，它会中断所有其他音频播放，允许应用程序使用硬件音频编解码器（MP3，AAC，Apple Lossless）。
> 	
> 默认情况下，当屏幕锁定时，音频将不再播放。要在此状态下播放音频，请使用**kAudioSessionCategory_MediaPlayback**音频会话类别。
> 	
> 即使在**电话被唤醒后**，屏幕**锁定时的音频静音也将保持沉默**。要在电话**休眠和唤醒后播放音频**，请设置**音频会话**，并在听到**中断结束时重新启动音频**。
> 	
> **AVAudioPlayer** 是AVFoundation中用于播放音频文件的新音频对象，提供以下内容：
> 	
> > 用于**播放、停止、暂停、设置时间和音量**的简单命令。
> > 将播放**AudioFile**和**AudioQueue**（用于实现此类的对象）识别的任何音频文件。
> > 提供委托来**处理构成服务组成部分的中断****AudioSession**。
> > 用户可以启用测量并使用结果值来呈现**任何给定时间正在播放的音频级别**的可视化显示。
> 	
 对象的用户仍然通过**音频会话API和类别控制音频**播放器的整体行为和交互。
> 	
> **kAudioFormatProperty_FirstPlayableFormatFromList='fpfl'**是添加到音频格式的新属性。该属性可用于从这些文件格式中选取**一个格式列表**，并从列表中返回列表中可在任何**给定设备上播放的第一种格式**。这是基于**规范中解码器和其他因素的可用性**，这些因素可能会影响给定实现呈现**比特流内容的能力**。如果**音频文件/流中的格式列表中有多个条目**，或者**FirstPlayableFormat**属性已实现，请执行以下操作：
> 	
> > 将该格式列表传递给此属性以获取应该用来**创建音频队列的实际格式的索引**。
> > 如果该属性没有实现（例如早期的iOS）,那么只需将格式**列表中的最后一项（这是最兼容的）创建为音频队列**。
	
	 
2.UIViewController

* 如果有一个nil的NIB名称被传递给**-initWithNibName:bundle:**并且视图控制器子类的**-loadView**没有被覆盖,那么视图控制器将尝试加载一个名称与视图控制器匹配的NIB。
* 应用程序**Info.plist**中的**UIInterfaceOrientation**属性现在在基本视图控制器的应用程序中得到了遵守。要在橫向中启动应用程序,请在属性列表中设置**UIInterfaceOrientation**属性,并确保视图控制器在**-shouldAutorotateToInterfaceOrientation:**中为所需的方向返回YES。
* 当以**模态方式呈现和解除视图控制器**时，使用正确的动画参数，出现和消失的方法将被**精确调用一次**以用于模态呈现或消除。
* 现在支持在**-viewWillAppear**中将第一个响应者设置为**UITextField**或**UITextView**。 这样做可以使键盘动画以匹配推送，弹出，模态存在或模式解除。


### [Known Issues(已知的问题)](https://developer.apple.com/library/content/releasenotes/iPhone/RN-iPhoneSDK/index.html#//apple_ref/doc/uid/TP40007428-CH1-SW2)

#### iOS Simulator (模拟器)

* iOS模拟器**不支持网络主目录**。
*  **模拟器平台中的Foundation版本包含iOS中未包含的功能**。为确保不使用iPhone上不存在的功能，请查看文档以获取可用性信息。

#### iOS UIDatePicker (时间控件)

* 在上午11点和下午12点之间切换可能会导致**日期选择器显示12AM而不是12PM**。

#### iOS UIImage (图片)

* 您必须指定图片扩展名**-imageNamed:**才能获得结果。

#### iOS UILabel (文本控件)

*  在格式字符串中包含度字符会**禁用对UILabel对象的文本更新**。
*  UILabel**忽略其contentModes属性**。

#### iOS UIScrollView (滚动控件)

* 缩放后，**内容插入将被忽略，内容将保留在错误的位置**。

#### iOS UIStringDrawing 

*  **UILineBreakModeTruncateHead**并且**UILineBreakModeMiddleTruncation**不适合多行文本。

#### iOS UITableView 

*  **UITableView**忽略**separatorStyle**和**separatorColor**。
*  **UITextView**嵌入在里面的物体**UITableViewCell**永远不会接收到触动。
*  定制行高（通过**tableView:heightForRowAtIndexPath:**）非常非常昂贵。
*  无法调整比屏幕更宽的表格。

#### iOS UITextField 

*  **UITextField**无法在**屏幕外退出第一响应者**。

#### iOS UITextView 

*  将**UITextView.editable**设置为**YES不应该自动显示键盘**。

#### iOS UIToolbarController 

*  **- [UIToolbarController setSelectionIndex]**不适用于**屏幕外的viewControllers数组的成员**。

#### iOS UIView 

*  如果使用**CGRectZero**框架进行初始化，许多**UIKit控件无法正确调整大小**。
*  **animationDidEnd过早触发**，如果您在回调中做了太多工作，可能会**导致动画停顿**。
*  如果一个**视图子类实现了-drawRect**：那么该视图子类的**背景颜色不能被动画化**。

#### iOS UIViewController 

* 如果UINavigationController的**barStyle更改为UIBarStyleBlackTranslucent**，将不会**自动调整内容视图的大小**。
* 如果视图从给定的UIViewController作为**顶层的nib对象**，但作为**插座连接**，则视图的**原点不正确地向上移动约24个像素**。


#### iOS UIWebView 

* 当WebKit是**单线程时**，**链接不会突出显示**。

#### Xcode /开发人员工具

* 您只能将**.png**文件用于设备的应用程序图标。
* iOS SDK专为基于Intel的Mac设计，并且在基于PPC的Mac上不受支持。
* Xcode和iOS SDK只能在**32位模式下工作; 不支持64位模式**。
* 在设备上运行和调试时，请务必关闭密码锁定。
* 固定：使用Xcode菜单运行>开始使用Performance Tool> <instrument>即使已启用也不起作用。该应用程序未上传到设备。当应用程序已存在时，乐器定位到本地机器，并且轨迹中出现“目标无法启动”。
* 尝试在同一设备上同时调试两个应用程序失败，并在调试器控制台中发生管道故障错误。
* 固定：仪器将连接多个设备时无法预测。



## IOS 3

[iOS 3.2 -> 2010-09-08](https://developer.apple.com/library/content/releasenotes/General/RN-iPhoneSDK-3_2/index.html#//apple_ref/doc/uid/TP40009477)

### [Introduction(介绍)](https://developer.apple.com/library/content/releasenotes/General/RN-iPhoneSDK-3_2/index.html#//apple_ref/doc/uid/TP40009477-CH1-SW13)

iOS SDK 3.2为开发iPad应用程序提供支持，并包含用于为iOS和Mac OS X创建应用程序的全套Xcode 3.2.2工具，编译器和框架。这些工具包括Xcode IDE和Instruments分析工具等。

使用此软件，您可以开发使用运行iOS 3.2的随附iOS模拟器在iPad上运行的应用程序。此外，您可以开发在iOS 3.1.3上运行的iPhone和iPod touch应用程序。（此软件不包含任何iOS SDK的2.x版本。）安装iOS SDK 3.2需要运行Mac OS X 10.6.2（Snow Leopard）或更高版本的Macintosh计算机。

我们鼓励开发人员向iOS开发人员计划申请访问其他支持资源，包括配置资源以直接在iPad，iPhone或iPod touch上进行开发。欲了解更多信息，

[http://developer.apple.com/devcenter/ios/program/](http://developer.apple.com/devcenter/ios/program/)


### [New in iOS SDK 3.2](https://developer.apple.com/library/content/releasenotes/General/RN-iPhoneSDK-3_2/index.html#//apple_ref/doc/uid/TP40009477-CH1-SW16)

> **Xcode 3.2.2**增加了对**开发iPad和通用iPad/iPhone**应用程序的支持。
> > Xcode通过帮助您更新现有iPhone项目以包含必要的文件来支持新设备，简化了在iPhone和iPad应用程序之间共享代码的过程。iPad升级当前目标...命令（在项目菜单中）允许您选择以下选项之一：
> > > 将现有iPhone目标升级为支持iPhone和iPad的通用应用程序。
> > > 
> > > 根据您的现有iPhone目标创建一个单独的iPad应用程序目标。
> > > 
> >  `它还创建了一些项目的xib文件的副本，并更新它们以支持iPad的更大屏幕尺寸。`
> > 
> > 使用升级当前目标for iPad ...命令后，如果需要，可以进一步调整项目的构建设置：
> > > 在iPad和iPhone上运行的通用应用程序需要具有以下构建设置：
> > > > 基础SDK构建设置（在体系结构部分中）必须设置为“iOS SDK 3.2”。
> > > > 
> > > > iOS部署目标版本设置必须设置为iOS 3.1.3或更低版本。
> > > > 
> > > 对于仅限iPad的开发，请将Base SDK设置为iOS SDK 3.2，并将iOS部署目标设置为iOS 3.2。
> > > 
> > > 对于仅限iPhone的开发，请将Base SDK设置为iOS SDK 3.1.3或更低版本，并将iOS部署目标设置为iOS 3.1.3或更低版本。
> > > 
> > > 根据您的应用程序，将目标设备系列构建选项设置为iPad，iPhone或iPhone / iPad。
> > 
> > 假设它们在iPad上运行，iOS模拟器3.2始终运行应用程序。因此，在iOS Simulator 3.2中运行通用应用程序将始终将其作为iPad应用程序运行，从而运行iPad代码路径。如果您想将通用应用程序作为iPhone应用程序运行，从而测试iPhone代码路径，则必须在iPhone或iPod touch设备上进行测试。
> 
> 鼓励开发人员使用Xcode的新建>生成和存档命令来创建其应用程序及其关联的[.dSYM]文件的存档。然后，此存档可与“组织者”中新的“存档的应用程序”源中的“验证应用程序...”，“共享应用程序...”和“将应用程序提交到iTunes Connect ...共享选项”一起使用。验证应用程序...并将应用程序提交给iTunes Connect ...共享选项需要iTunes Connect帐户和为该应用程序准备的元数据; 验证应用程序...将运行所有将提交到App Store后运行的验证测试，以便您在提交应用程序之前修复任何问题。将应用程序提交给iTunes Connect ...运行与验证应用程序相同的验证测试...然后，如果所有测试都通过，
> 
> 您现在可以轻松将您的iPhone开发者身份转移到新计算机上。组织者中新的开发人员简介源允许您将供应配置文件和身份（代码签名证书）导出为安全的单个文件。要开始在新计算机上开发，请使用Organizer将该文件导入到Xcode中，或者在Finder中双击该文件。
> 
> Interface Builder支持iPad平台可用的新视图控制器和窗口大小。

有关最新的安全信息，请访问：[http://support.apple.com/kb/HT1222](http://support.apple.com/kb/HT1222)。有关新工具功能的更多详细信息，请参阅完整的Xcode 3.2.2发行说明。

### [Bug Reporting (错误报告)](https://developer.apple.com/library/content/releasenotes/General/RN-iPhoneSDK-3_2/index.html#//apple_ref/doc/uid/TP40009477-CH1-SW3)

请使用Developer Connection网站上的Apple Bug Reporter报告“已知问题”一节中未提及的任何错误：[http://developer.apple.com/bugreporter/](http://developer.apple.com/bugreporter/)。


### [Known Issues and Fixes(已知问题和修复)](https://developer.apple.com/library/content/releasenotes/General/RN-iPhoneSDK-3_2/index.html#//apple_ref/doc/uid/TP40009477-CH1-SW2)

#### Xcode/Developer Tools (Xcode/开发人员工具)

* 您无法使用模拟器在3.2操作系统上测试iPhone应用程序。
* 您只能将.png文件用于设备的应用程序图标。
* 在设备上运行和调试时，请务必关闭密码锁定。
* 尝试在同一设备上同时调试两个应用程序失败，并在调试器控制台中发生管道故障错误。
* 使用Project> Upgrade Current Target for iPad ...命令将现有iPhone目标升级到Universal应用程序目标后，应验证已升级的目标的iOS Deployment Target设置已设置为iOS 3.1.3或更低版本。

### Core Graphics (核心动画)

**[CGFontCreateWithFontName](https://developer.apple.com/documentation/coregraphics/1396330-cgfontcreatewithfontname)** can hang in some circumstances when using the **UIAppFonts** key in the **Info.plist**.

### Interface Builder (界面生成器)

* 为支持外部本地化工具和工作流程，Interface Builder 3.2.2支持将iPhone文档保存为可编辑的nib格式的选项。此外，Xcode构建设置“拼合编译的XIB文件”和“剥离NIB文件”现在适用于iPhone Interface Builder文档，其应用方式与Mac OS X文档相同。默认情况下，nib文件在构建时将被剥离。
* iOS 3.2支持加载未划分的nib文件，但是3.2之前的iOS版本不支持。如果您选择构建untripped nib文件以支持本地化工作流程，则应该使用ibtool的--strip命令在本地化后剥离nib文件，或临时还原“拼合编译的XIB文件”和“剥离NIB文件”构建设置以构建nib文件与以前的iOS版本兼容。
* 构建使用**[UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell)**XIB文件中编码的对象并在模拟器或小于3.2版本的设备上运行该应用程序的iPhone应用程序将导致运行时异常。要解决此问题，请在iOS SDK 3.2中使用模拟器。


### MapKit

* 以前，路线URL是作为单个点对点请求递交的。在iOS 3.2中，它被处理为两组搜索查询和结果，可以同时运行。拼写检查，优化和地图平移/缩放的地图用户界面现在支持并发搜索。

### MediaPlayer (媒体播放器)

* 当电影以非全屏模式启动并切换到全屏模式时，不会从完成按钮发送**[MPMoviePlayerPlaybackDidFinishNotification](https://developer.apple.com/documentation/mediaplayer/mpmovieplayerplaybackdidfinishnotification)**通知。 点击完成按钮后播放不会结束 - 视频仍处于播放状态，只是暂停播放。 相反，请参阅**[MPMoviePlayerWillExitFullscreenNotification](https://developer.apple.com/documentation/foundation/nsnotification.name/1620855-mpmovieplayerwillexitfullscreen)** / **[MPMoviePlayerDidExitFullscreenNotification](https://developer.apple.com/documentation/foundation/nsnotification.name/1620945-mpmovieplayerdidexitfullscreen)**。
* 您可以将几个电影视图合并到您的应用程序中，但只有其中一个视图可以在任何给定时间播放其电影。

### MessageUI 

* **Message UI**框架导出没有前缀的类名，这可能会导致名称空间混乱。 如果您使用的是消息UI框架，请注意有关重复符号的编译器警告。 为避免名称空间问题，可以将前缀添加到您自己的类名称中。

### Simulator (模拟器) 

* 在iPad模拟器下启动照片应用程序最初将显示三个选项卡：照片，相册和相机。 “摄像头”选项卡表示可通过iPad的相机连接套件获得的照片，并且与模拟器无关。 几秒钟后，“相机”选项卡将消失。

### Springboard (跳板)

* FIXED：Springboard现在使用一个新的`Info.plist`键来定义`Default.png`图像名称：`UILaunchImageFile`。


### Status Bar (状态栏)

* iPad上不支持状态栏透明。


### UIKit 

* 文本输入系统从未调用“Geometry and Hit-Testing Methods”类别下的文档中找到的方法。
* 文本输入系统从未调用“Determining Layout and Writing Direction”类别下的文档中找到的方法。

### UIPopoverController 

* [MPMediaPickerController](https://developer.apple.com/documentation/mediaplayer/mpmediapickercontroller)和[UIImagePickerController](https://developer.apple.com/documentation/uikit/uiimagepickercontroller)类不受UIViewController的[presentModalViewController:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621465-presentmodalviewcontroller)animated：方法支持。 这些选择器应该使用UIPopoverController对象来显示。
* 现在需要有一个箭头。
* NEW：在[viewWillAppear:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621510-viewwillappear)方法中初始化时，Popovers会忽略[contentSizeForViewInPopover](https://developer.apple.com/documentation/uikit/uiviewcontroller/1619323-contentsizeforviewinpopover)属性中的值。


### UITableView 

* [UITableViewCellStyleValue1](https://developer.apple.com/documentation/uikit/uitableviewcellstyle/1623267-value1)样式现在也支持图像。
* [UITableViewRowAnimationMiddle](https://developer.apple.com/documentation/uikit/uitableviewrowanimation/1614978-middle)样式现在为行删除提供动画。


### UIWebView 

* 用户代理字符串已更新为iPad。



## IOS 4 

### [iOS 4.0.2 -> 2010-08-10](https://developer.apple.com/library/content/releasenotes/General/RN-iPhone-4_0_2/index.html#//apple_ref/doc/uid/TP40010239)

#### [Introduction(介绍)](https://developer.apple.com/library/content/releasenotes/General/RN-iPhone-4_0_2/index.html#//apple_ref/doc/uid/TP40010239-CH1-SW3)

* iOS SDK 4.0.2是对iOS 4.0或iOS 4.0.1的更新，它为开发iPhone和iPod touch应用程序提供支持，并包括用于为iOS和Mac OS X创建应用程序的全套Xcode工具，编译器和框架。 这些工具包括Xcode IDE和Instruments分析工具等等。
* 使用此软件，您可以使用附带的iOS模拟器开发在iPhone或iPod touch上运行的应用程序。 安装iOS SDK 4.0.2需要运行Mac OS X 10.6.2（Snow Leopard）或更高版本的Macintosh计算机。
* 我们鼓励开发人员向iOS开发人员计划申请访问其他支持资源，包括配置资源以直接在iPhone或iPod touch上进行开发。 欲了解更多信息，

[http://developer.apple.com/devcenter/ios/program/](http://developer.apple.com/devcenter/ios/program/)

#### [Bug Reporting(错误报告)](https://developer.apple.com/library/content/releasenotes/General/RN-iPhone-4_0_2/index.html#//apple_ref/doc/uid/TP40010239-CH1-SW4)

请使用Developer Connection网站上的Apple Bug Reporter报告“已知问题”一节中未提及的任何错误：[http://developer.apple.com/bugreporter/](http://developer.apple.com/bugreporter/)。

#### [Known Issues(已知问题)](https://developer.apple.com/library/content/releasenotes/General/RN-iPhone-4_0_2/index.html#//apple_ref/doc/uid/TP40010239-CH1-SW2)

以下问题与使用4.0 SDK开发代码有关。

#### UIAutomation (已知问题)

> 此版本中的自动化工具查找iOS Simulator 4.0.2文件夹下的`com.apple.Accessibility.plist`文件; 但是，如果该SDK已安装，则它仅存在于iOS Simulator 4.0文件夹下。 您可以通过在iOS模拟器4.0和4.0.2文件夹之间建立符号链接来解决此问题。
> 按照以下步骤在iOS模拟器4.0和4.0.2文件夹之间创建符号链接：
> > 如果它们正在运行，请退出仪器和iOS模拟器。
> > 在机器上的终端应用程序中运行以下命令：
> > `cd〜/ Library / Application \ Support / iPhone \ Simulator /`
> > 
> > `ln -s 4.0.2 4.0`
>
> 您可以在iOS Reference Library中的Q＆A 1705中找到更多详细信息。


### [iOS 4.1 -> 2010-08-27](https://developer.apple.com/library/content/releasenotes/General/RN-iPhoneSDK-4_1/index.html#//apple_ref/doc/uid/TP40010153)

#### Introduction (介绍) 

* iOS SDK 4.1为开发iOS应用程序提供支持，并包括用于为iOS和Mac OS X创建应用程序的完整Xcode工具，编译器和框架。这些工具包括Xcode IDE和Instruments分析工具等等。
* 使用此软件，您可以开发在运行iOS 4.1的iPhone或iPod touch上运行的应用程序。 此外，您可以开发运行iOS 3.2的iPad应用程序。 您还可以使用包含iOS 4.1和iOS 3.2的随附iOS模拟器测试您的应用程序。 安装iOS SDK 4.1需要运行Mac OS X 10.6.2（Snow Leopard）或更高版本的Macintosh计算机。
* 我们鼓励开发人员向iOS开发人员计划申请访问其他支持资源，包括配置资源以直接在基于iOS的设备上进行开发。 欲了解更多信息，
* http://developer.apple.com/devcenter/ios/program/

```
	iOS SDK 4.1 provides support for developing iOS applications and includes the complete set of Xcode tools, compilers, and frameworks for creating applications for iOS and Mac OS X. These tools include the Xcode IDE and the Instruments analysis tool among many others.

	With this software you can develop applications that run on iPhone or iPod touch running iOS 4.1. Additionally, you can develop applications for iPad, which runs iOS 3.2. You can also test your applications using the included iOS Simulator, which supports both iOS 4.1 and iOS 3.2. Installing iOS SDK 4.1 requires a Macintosh computer running Mac OS X 10.6.2 (Snow Leopard) or later.

	We encourage developers to apply to the iOS Developer Program for access to additional support resources, including provisioning resources to enable development directly on an iOS-based device. For more information visit:

	http://developer.apple.com/devcenter/ios/program/
```

#### Bug Reporting (错误报告) 

请使用Developer Connection网站上的Apple Bug Reporter报告“已知问题”一节中未提及的任何错误：http://developer.apple.com/bugreporter/。

```
	Please report any bugs not mentioned in the "Known Issues" section using the Apple Bug Reporter on the Developer Connection website at: http://developer.apple.com/bugreporter/.
```

#### Known Issues (已知问题) 

以下问题与使用4.1 SDK开发代码有关。

```
	The following issues relate to using the 4.1 SDK to develop code.
```

#### Xcode 

如果您使用的是Mac OS X 10.6.3或更低版本，则在执行干净的构建时，Xcode有时可能会挂起。 要解决此问题，请升级到Mac OS X 10.6.4（软件更新为Snow Leopard）。

```
	Xcode can hang sometimes when doing a clean build if you are running on Mac OS X 10.6.3 or lower. To fix this problem please upgrade to Mac OS X 10.6.4 (Software update to Snow Leopard).
```

#### AVFoundation 

AVQueuePlayer类现在在AV Foundation中可用。 这个类允许你播放一系列AVPlayerItem对象。
AVAssetReader和AVAssetWriter类及其支持类现在可在AV Foundation中使用。 AVAssetReader类允许客户从媒体读取解压缩的样本。 AVAssetWriter类允许客户提供压缩和文件写入的未压缩样本。

```
	The AVQueuePlayer class is now available in AV Foundation. This class allows you to play a sequence of AVPlayerItem objects.
	The AVAssetReader and AVAssetWriter classes and their supporting classes are now available in AV Foundation. The AVAssetReader class allows clients to read decompressed samples from media. The AVAssetWriter class allows clients to supply uncompressed samples for compression and file writing.
```

#### Debugger

在调试支持多任务的应用程序时，避免在应用程序在后台挂起时手动暂停并从调试器继续。 暂停在后台挂起的应用程序会中断正确的多任务处理行为，直到应用程序重新启动。

```
	When debugging your multitasking enabled app, avoid manually pausing and continuing from the debugger when the application is suspended in the background. Pausing an application that is suspended in the background disrupts proper multitasking behavior until the application is relaunched.
``` 

#### GameKit

* 在此版本中，支持Game Center的应用程序的软件包名称必须符合RFC1808。 它可能不包含'pchar'定义中不允许的空格或其他字符。
* Game Center支持iPhone 4，iPhone 3GS和iPod touch（第二代及更高版本）
* 要访问排行榜，应用程序现在需要指定排行榜的类别标识符字符串。
* 之前返回的或使用GKPlayer对象的API现在需要播放器标识符字符串。
* 范围检查例外已添加到排行榜请求中。
* 应用不再有权访问玩家的状态。
* 不再支持使用iOS 4 Game Center Preview的应用程序。 只支持使用iOS 4.1（或更高版本）Game Center的应用程序。
* 对于这个版本，GameKitPreview.h被重命名为Gamekit.h。
* 对于iOS 4.1，playerID属性（GKPlayer类的）使用的字符串格式已更改。 你的应用程序不应该假定任何关于播放器标识符字符串的长度或格式。

```
	In this release, a Game Center-aware application's bundle name must conform to RFC1808. It may not include spaces or other characters not allowed in the definition for 'pchar'.
	Game Center supports iPhone 4, iPhone 3GS, and iPod touch (second-generation and higher)
	To access a leaderboard, applications now need to specify the leaderboard's category identifier string.
	APIs that previously returned or took a GKPlayer object now take a player identifier string.
	A range checking exception has been added to leaderboard requests.
	Apps no longer have access to the players' status.
	Apps using the iOS 4 Game Center Preview are no longer supported. Only apps using the iOS 4.1 (or greater) version of Game Center are supported.
	For this release, GameKitPreview.h was renamed Gamekit.h.
	For iOS 4.1, the string format used by the playerID property (of the GKPlayer class) changed. Your application should never assume anything about the length or format of a player identifier string.
```

#### iAd

在某些情况下，更改ADBannerView的中心，变换，边界或alpha属性可能没有预期的结果。 要在更改这些属性时确保正确的结果，请在更改这些属性后重置隐藏属性。 例如：
bannerView.center = newCenter;

bannerView.hidden = bannerView.hidden;

将ADBannerView的alpha属性动画化为0.0可能无法正确呈现。 要解决此限制，请使用大于0.0的较小值，如0.01。

```
	In some cases, changing the center, transform, bounds, or alpha properties of an ADBannerView may not have the expected outcome. To ensure correct results when changing these properties, reset the hidden property after changing these properties. For example:
bannerView.center = newCenter;

		bannerView.hidden = bannerView.hidden;

Animating the alpha property of an ADBannerView to 0.0 may not render correctly. To work around this limitation, use a small value greater than 0.0, such as 0.01.
```

#### Instruments

新功能：在能量诊断仪器中，CPU活动工具不报告前台应用程序，音频处理和图形的活动

```
	NEW: In Energy Diagnostic instrument the CPU activity instrument is not reporting activity for Foreground app, Audio processing and Graphics
```

#### Media Player

如果您的应用程序播放背景音频，建议您实施对远程控制事件的支持，以让用户直接从应用程序切换器控制音频。 有关更多信息，请参阅iOS事件处理指南中的多媒体远程控制。

```
	If your application plays background audio, it is recommended that you implement support for remote-control events to let users control the audio directly from the application switcher. For more information, see Remote Control of Multimedia in Event Handling Guide for iOS.
```

#### Simulator

新：对于模拟器SDK，不显示静态分析器结果。 要解决此问题，您可以从总览弹出窗口切换到设备SDK。
新增功能：模拟器中带有4.0.1 SDK的iPhone 4配置文件将无法正常运行。 您可以通过以下方式解决问题：
sudo ln -s \

/Developer/Platforms/iOS Simulator.platform/Developer/SDKs/iOS Simulator4.0.sdk/System/Library/CoreServices/SpringBoard.app/N90AP.plist

/Developer/Platforms/iOS Simulator.platform/Developer/SDKs/iOS Simulator4.0.sdk/System/Library/CoreServices/SpringBoard.app/iPhone4Simulator.plist

```
	NEW: For the simulator SDKs Static Analyzer results are not displayed. To workaround this problem you can switch to device SDKs from the overview pop-up.
	NEW: The iPhone 4 profile with the 4.0.1 SDK in the simulator will not behave correctly. You can workaround the problem by:
sudo ln -s \

	/Developer/Platforms/iOS Simulator.platform/Developer/SDKs/iOS Simulator4.0.sdk/System/Library/CoreServices/SpringBoard.app/N90AP.plist

	/Developer/Platforms/iOS Simulator.platform/Developer/SDKs/iOS Simulator4.0.sdk/System/Library/CoreServices/SpringBoard.app/iPhone4Simulator.plist
```

#### UIKit

在过渡动画块中设置一些动画属性可能不起作用。
iOS 4中新的基于UIView块的动画API的默认行为是在动画播放时禁用整个界面的用户交互。开发人员不应该依赖这种行为保持默认状态，因为它可能在未来的版本中被颠倒过来，从而允许在动画播放时默认进行用户交互。针对iOS SDK 4编译的程序将继续按原样运行，但在未来版本的SDK下编译的代码可能需要设置不同的选项标志以启用原始行为。
iOS 4中新的基于UIView块的动画API的默认行为是从封闭动画块（如果存在）继承动画持续时间。开发人员不应该依赖这种行为仍然是默认行为，因为它可能会在将来的版本中颠倒过来，从而阻止动画自动继承其封闭动画的持续时间。针对iOS SDK 4.0编译的程序将继续按原样工作，但在未来版本的SDK下编译的代码可能需要设置不同的选项标志以启用原始行为。

```
	Setting some animatable properties inside a transition animation block may not work.
	The default behavior for the new UIView block-based animation API in iOS 4 is to disable user interactions across the whole interface while the animation is playing. Developers should not rely on this behavior remaining the default as it may be reversed in future releases, thereby allowing user interactions to occur by default while the animation is playing. Programs compiled against iOS SDK 4 will continue to work as-is, but code compiled under future versions of the SDK may require setting a different option flag to enable the original behavior.
	The default behavior for the new UIView block-based animation API in iOS 4 is to inherit the animation duration from an enclosing animation block (when present). Developers should not rely on this behavior remaining the default, as it may be reversed in future releases, thereby preventing animations from automatically inheriting the duration of their enclosing animation. Programs compiled against iOS SDK 4.0 will continue to work as-is but code compiled under future versions of the SDK may require setting a different option flag to enable the original behavior.
```

### [iOS 4.2 -> 2010-11-15](https://developer.apple.com/library/content/releasenotes/General/RN-iOSSDK-4_2/index.html#//apple_ref/doc/uid/TP40010243)

#### Introduction (介绍) 

iOS SDK 4.2为开发iOS应用程序提供支持，并包括用于为iOS和Mac OS X创建应用程序的完整Xcode工具，编译器和框架。这些工具包括Xcode IDE和Instruments分析工具等等。

借助此软件，您可以开发运行在运行iOS 4.2的iPhone，iPad或iPod touch上的应用程序。 您还可以使用支持iOS 4.2的随附iOS模拟器测试您的应用程序。 安装iOS SDK 4.2需要运行Mac OS X 10.6.4（Snow Leopard）或更高版本的Macintosh计算机。

有关更多信息和其他支持资源，请访问：

http://developer.apple.com/programs/ios/

```
	iOS SDK 4.2 provides support for developing iOS applications and includes the complete set of Xcode tools, compilers, and frameworks for creating applications for iOS and Mac OS X. These tools include the Xcode IDE and the Instruments analysis tool among many others.

	With this software you can develop applications that run on iPhone, iPad, or iPod touch running iOS 4.2. You can also test your applications using the included iOS Simulator, which supports iOS 4.2. Installing iOS SDK 4.2 requires a Macintosh computer running Mac OS X 10.6.4 (Snow Leopard) or later.

	For more information and additional support resources, visit:

	http://developer.apple.com/programs/ios/
```

#### Bug Reporting (错误报告)

请使用Apple开发人员网站上的Apple Bug Reporter报告**Notes和已知问题**部分中未提及的任何错误：[http://developer.apple.com/bugreporter/](http://developer.apple.com/bugreporter/)。 另外，您可以在Apple开发者论坛中讨论这些问题和iOS SDK 4.2：[http://devforums.apple.com](http://devforums.apple.com)。

```
	Please report any bugs not mentioned in the Notes and Known Issues section using the Apple Bug Reporter on the Apple Developer website at: http://developer.apple.com/bugreporter/. Additionally, you may discuss these issues and iOS SDK 4.2 in the Apple Developer Forums: http://devforums.apple.com.
``` 

#### Notes and Known Issues (笔记和已知问题)

以下问题与使用4.2 SDK开发代码有关。

```
	The following issues relate to using the 4.2 SDK to develop code.
```

#### Xcode

* 如果您将iPad从iOS 4.2 GM Seed升级到iOS 4.2 GM，则Xcode将在首次连接设备时从设备中提取符号。 这个过程只需要几分钟。
* 有一个新的基础SDK设置称为“最新的SDK”。 这是所有项目的推荐选择，并会导致您的项目始终针对最新的可用iOS SDK进行构建。
* 如果项目是使用早于iOS SDK 4.2的SDK创建的，则“概述”弹出式菜单将显示“缺少基本SDK”。 但是，选择新的SDK后，“概述”弹出窗口仍可能显示“基本SDK缺失”。
* 要解决该问题，请关闭并重新打开项目窗口。

```
	If you are upgrading your iPad from iOS 4.2 GM Seed to iOS 4.2 GM, Xcode will extract symbols from the device the first time you connect the device. This process takes only a few minutes.
	There is a new Base SDK setting called "Latest SDK". This is the recommended choice for all projects and will cause your project to always build against the newest available iOS SDK.
	The Overview popup menu will display "Base SDK Missing" if a project was created with an SDK earlier than iOS SDK 4.2. However, after selecting a new SDK that Overview popup may still display "Base SDK Missing".
	To work around the issue, close and reopen the project window.
```

#### Audio

* iPad屏幕旋转锁定开关现在在iOS 4.2中用作声音/静音开关。 此开关的行为与iPhone上的响铃/静音开关的行为相同。
* 针对iPad的应用程序在实施音频行为时需要考虑到这一点。
* 有关音频行为准则以及如何实现的更多信息，请参阅iPhone人机界面准则中的用户体验准则和[音频会话编程指南](https://developer.apple.com/library/content/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007875)。

```
	The iPad screen rotation lock switch now functions as a sound/silent switch in iOS 4.2. This switch behaves the same way as the Ring/Silent switch on iPhone.
	Applications targeted for iPad will need to take this into account when implementing audio behaviors.

	For more information on audio behavior guidelines and how to implement them, see User Experience Guidelines in iPhone Human Interface Guidelines and the Audio Session Programming Guide.
```

#### Calendar

日历现在可以直接导入.ics文件作为添加事件的方式。 如果您的应用程序可以访问.ics文件，则应该使用[UIDocumentInteractionController](https://developer.apple.com/documentation/uikit/uidocumentinteractioncontroller)API测试导入它们。

```
	Calendar can now import .ics files directly as a way to add events. If your app has access to .ics files, you should test importing them using the UIDocumentInteractionController API.
```

#### GameKit

* 应用程序可以使用[GKFriendRequestComposeViewController](https://developer.apple.com/documentation/gamekit/gkfriendrequestcomposeviewcontroller)类来启动好友请求。
* GameKit视图控制器的排行榜，成就，牵线搭桥和好友请求必须以模态方式呈现。 以任何其他方式呈现它们将导致异常和意外行为。 这会影响[GKLeaderboardViewController](https://developer.apple.com/documentation/gamekit/gkleaderboardviewcontroller)，[GKAchievementViewController](https://developer.apple.com/documentation/gamekit/gkachievementviewcontroller)，[GKMatchmakerViewController](https://developer.apple.com/documentation/gamekit/gkmatchmakerviewcontroller)和[GKFriendRequestComposeViewController](https://developer.apple.com/documentation/gamekit/gkfriendrequestcomposeviewcontroller)。
* 在iOS 4.2中，当应用程序进入前台时，本地播放器会再次自动进行身份验证。 这将生成认证更改通知。 如果应用程序与iOS 4.2或更高版本链接，则认证完成处理程序也将被调用（它将被无限期保留）。

```
	Applications can use the GKFriendRequestComposeViewController class to initiate friend requests.
	The GameKit view controllers for leaderboards, achievements, matchmaking, and friend requests must be presented modally. Presenting them any other way will result in an exception and unexpected behavior. This affects GKLeaderboardViewController, GKAchievementViewController, GKMatchmakerViewController and GKFriendRequestComposeViewController.
	In iOS 4.2, the local player is automatically authenticated again when an app enters the foreground. This will generate an authentication changed notification. If the app is linked with iOS 4.2 or later, the authentication completion handler will also be called (it is retained indefinitely).
```

#### GDB

在调试过程中，暂停或恢复iOS应用程序的后台操作当前不受支持，并可能导致未定义的应用程序行为。

```
	During debugging, pausing or resuming an iOS application while it is backgrounded is currently unsupported and can result in undefined application behavior.
```

#### MapKit

对于针对iOS 4.2及更高版本构建的应用程序，MapKit现在将有条件地显示基于地图当前可见区域的注释视图。 为了解决这个问题，开发者应该确保他们按照文档重复使用注释视图，并且永远不要假定没有注释视图意味着没有相应的注释

```
	For applications built against iOS 4.2 and later, MapKit will now conditionally display annotation views based on the currently visible region of the map. To account for this, developers should make sure they reuse annotation views as documented and never assume that the absence of an annotation view implies the absence of a corresponding annotation
```

#### Printing

iOS 4.2设备可以仅通过无线方式打印到支持AirPrint的打印机并运行最新的可用固件。 一些当前可用的支持AirPrint的打印机有：
	HP Photosmart高级传真e-all-in-One打印机 - C410
	HP Photosmart高级电子多功能一体机 - C310
	HP Photosmart Plus e-all-in-One打印机系列 - B210
	HP ENVY 100 e-All-in-One打印机系列 - D410
	HP Photosmart eStation打印机系列 - C510

```
	iOS 4.2 devices can print wirelessly only to printers that support AirPrint and are running the latest available firmware. Some currently available printers that support AirPrint are:
		HP Photosmart Premium Fax e-All-in-One Printer - C410
		HP Photosmart Premium e-All-in-One Printer series - C310
		HP Photosmart Plus e-All-in-One Printer series - B210
		HP ENVY 100 e-All-in-One Printer Series - D410
		HP Photosmart eStation Printer series - C510
```

#### Simulator

构建一个将CoreVideo.framework与4.2 Simulator SDK薄弱链接，然后在3.2模拟器上运行该应用程序的应用程序将导致崩溃。 在针对4.2设备SDK进行构建并在3.2设备上运行时，相同的配置将起作用。

```
	Building an app that weak links CoreVideo.framework against the 4.2 Simulator SDK and then running that application against the 3.2 Simulator will result in a crash. The same configuration will work when building against the 4.2 device SDK and running on a 3.2 device.
```

#### Weak Linking (弱链接)

以下框架目前不支持通过`NS_CLASS_AVAILABLE`宏进行弱链接：

* 	AV基金会
* 	核心动画
* 	核心电话
* 	移动启动服务

当针对较早版本的iOS时，您可以通过调用[NSClassFromString](https://developer.apple.com/documentation/foundation/1395135-nsclassfromstring)函数并查看它是否返回非零值来检查这些框架中的类可用性。 有关使用`NS_CLASS_AVAILABLE`宏的信息，请参阅[iOS中的新增功能中](https://developer.apple.com/library/content/releasenotes/General/WhatsNewIniOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008246)的iOS 4.2。

```
	The following frameworks currently do not support weak linking by way of the NS_CLASS_AVAILABLE macro:
		AV Foundation
		Core Animation
		Core Telephony
		MobileLaunchServices
		When targeting older versions of iOS, you can check the class availability in these frameworks by calling the NSClassFromString function and seeing if it returns a non-nil value. For information about using the NS_CLASS_AVAILABLE macro, see iOS 4.2 in What's New in iOS.
```

