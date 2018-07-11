---
title: 推送
date: 2018-07-10 16:23:59
tags: IOS,APNs
---

# [推送](https://blog.serverdensity.com/how-to-build-an-apple-push-notification-provider-server-tutorial/)

## [条件前提](https://developer.apple.com/account/ios/identifier/bundle)

**苹果的远程推送是分测试和发布服务器的:**

1.  测试服务器地址: gateway.sandbox.push.apple.com 2195
2. 发布服务器地址: gateway.push.apple.com 2195

### AppID

![](/images/apns/apns_add_appId.jpg)

### 开发和发布证书

![](/images/apns/apns_init_development_production.jpg)


### CertSigningRequest证书


![](/images/apns/apns_init_setting_certSigningRequest.jpg)


### Provisioning Profile证书

![](/images/apns/apns_init_setting_provisioningProfile.jpg)

### 下载Provisioning Profile证书

![](/images/apns/apns_download_cer.jpg)


### 导出Development公钥和私钥

![](/images/apns/apns_publicKey_privateKey.jpg)

## 工程配置

1. 在对应Bundle ID的工程中开启ATS:

	![](/images/apns/apns_开启ATS.jpg)

2. 在Targets->Capabilities->Push Notifications，右边开启次功能

  ![](/images/apns/apns_background_modes.jpg)
  
  ![](/images/apns/apns_push_notification.jpg)
  
  

## 处理证书

打开**终端**,切换到前面所说三个文件下位置,**例如:cd ......**


### Java、.Net后台证书

![](/images/apns/apns_java_net_p12.jpg)

### PHP后台证书

1. 把公钥.cer的SSL证书转换为.pem文件

	```
		openssl pkcs12 -clcerts -nokeys -out apns-dev-cert.pem -in apns-dev-cert.p12
	```
	
2. 把私钥.cer的SSL证书转换为.pem文件

	```
		openssl pkcs12 -nocerts -out apns-dev-key.pem -in apns-dev-key.p12
	```

3. 把公钥.pem和私钥.pem合成一个最终的pem

	```
		cat apns-dev-cert.pem apns-dev-key.pem > apns-dev.pem
	```

## 测试证书

1. 检查你的服务器的端口 2195是否已经开启,是否被关闭了或是防火墙阻止了!这点很重要;如果你不确定,又出现了错误,请先向你的服务器商询问一下,并开启。
2. 确认你的证书没有问题

```
	openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert apns-dev-cert.pem -key apns-dev-key-noenc.pem -debug -showcerts -CAfile "apns-dev.pem"
	
	openssl s_client -connect gateway.push.apple.com:2195 -cert apns-dev-cert.pem -key apns-dev-key-noenc.pem -debug -showcerts -CAfile "apns-dev.pem"

```


**推荐一款应用程序: Knuff 测试推送工具**


## 服务器后台

### Java

```
	import javapns.back.PushNotificationManager;
	import javapns.back.SSLConnectionHelper;
	import javapns.data.Device;
	import javapns.data.PayLoad;
	
	public class PushDemo {
	
	    public static void main(String[] args) {
	
	        try {
	            String deviceToken = "9d404fbce15e51c619a2bbaa68b81a4ab67c8a98959e859df6d704008292601b";//iphone手机获取的token
	
	            PayLoad payLoad = new PayLoad();
	            payLoad.addAlert("我的push测试");//push的内容
	            payLoad.addBadge(1);//图标小红圈的数值
	            payLoad.addSound("basic_tones.mp3");//铃音
	
	            PushNotificationManager pushManager = PushNotificationManager.getInstance();
	            pushManager.addDevice("iPhone", deviceToken);
	
	            //Connect to APNs
	            /************************************************
	             测试的服务器地址：gateway.sandbox.push.apple.com /端口2195
	             产品推送服务器地址：gateway.push.apple.com / 2195
	             ***************************************************/
	            String host= "gateway.sandbox.push.apple.com";
	            int port = 2195;
	            String certificatePath= "/Users/wubin/Desktop/syt_development.p12";//导出的证书
	            String certificatePassword= "123456";//此处注意导出的证书密码不能为空因为空密码会报错
	            pushManager.initializeConnection(host,port, certificatePath,certificatePassword, SSLConnectionHelper.KEYSTORE_TYPE_PKCS12);
	
	            //Send Push
	//            System.setProperty("https.protocols", "TLSv1.2,TLSv1.1,SSLv3");
	            Device client = pushManager.getDevice("iPhone");
	            pushManager.sendNotification(client, payLoad);
	            pushManager.stopConnection();
	
	            pushManager.removeDevice("iPhone");
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	        }
	
	    }
	}
```

### PHP

```
	<?php
		/*
		官方文档https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/CommunicatingWIthAPS.html
		*/
		$apnsHost = 'gateway.push.apple.com';
		$apnsPort = 2195;
		$apnsCert = 'apns-production.pem';
		$aData['aps'] = array('alert' => '收到后请给李高峰个电话', 'badge' => 1, 'sound' => 'default');
		$payload = json_encode($aData);
		$streamContext = stream_context_create();
		$res = stream_context_set_option($streamContext, 'ssl', 'local_cert', $apnsCert);
		$apns = stream_socket_client('ssl://' . $apnsHost . ':' . $apnsPort, $error, $errorString, 2, STREAM_CLIENT_CONNECT, $streamContext);
		 if (!$apns) {
		    print "Failed to connect $err $errstrn";
		    return false;
		}
		$deviceToken = 'd14e47t13d258f6d5a4d48547a6d1826f2a6b80fefd9d3119cadf0102648ed0';
		$apnsMessage = chr(0) . chr(0) . chr(32) . pack('H*', str_replace(' ', '', $deviceToken)) . chr(0) . chr(strlen($payload)) . $payload;
		 
		$result = fwrite($apns, $apnsMessage);
		if ($result) {
		    echo 'Message successfully delivered';
		} else {
		    echo 'Message not delivered';
		}
		socket_close($apns);
		fclose($apns);
	?>
```