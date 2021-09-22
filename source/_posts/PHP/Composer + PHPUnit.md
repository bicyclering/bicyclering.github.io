---
title: PhpStrom + Composer + PHPUnit + XAMPP
date: 2021-08-20 21:20:42
tags: Composer
categories: PHP
---


# PhpStrom + Composer + PHPUnit + XAMPP


## Question

### Root composer.json requires monolog/monolog, it could not be found in any version,.....


> 1. [更改阿里云Composer全量镜像](https://www.runoob.com/w3cnote/composer-install-and-usage.html)
> 
> > 1.1  全局模式
> > > `composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/`
> > > 
> > >  `composer config -g --unset repos.packagist`
> >  
> >  1.2 仅当前项目配置
> > > `composer config repo.packagist composer https://mirrors.aliyun.com/composer/`
> > > 
> > > `composer config --unset repos.packagist`
> >  
> > 1.3 配置完成后调试
> > > `composer -vvv require alibabacloud/sdk`


### PHPUnit Cannot open file "XXXTest"

![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/PHPUnit/3.jpg)

> PHPUnit 9 isn't supported in PhpStorm **2018.3.3. or 2019.3.3.** Please use PHPUnit 8.*, use EAP build  2020.1 release .
> > **edit composer.json**
> > > initial 
> > > > `"require-dev": {"phpunit/phpunit": "9.5.8"}`
> > > 
> > > finally
> > > > `"require-dev": {"phpunit/phpunit": "8.*"}`


### homebrew install fail

> `source /Users/willson/.zprofile`


### [Xdebug: [Config] The setting 'xdebug.remote_enable' has been renamed, see the upgrading guide at https://xdebug.org/docs/upgrade_guide#changed-xdebug.remote_enable (See: https://xdebug.org/docs/errors#CFG-C-CHANGED)](https://xdebug.org/docs/errors#CFG-C-CHANGED)

#### config php.ini

	xdebug.client_host = 127.0.0.1	xdebug.client_port = 9000	xdebug.mode = debug`


### config GD

#### windows

> [https://forums.modx.com/thread/49552/fatal-error-call-to-undefined-function-imagecreatefromjpeg-on-local-windows](https://forums.modx.com/thread/49552/fatal-error-call-to-undefined-function-imagecreatefromjpeg-on-local-windows)
> 
> [https://sourceforge.net/projects/gnuwin32/](https://sourceforge.net/projects/gnuwin32/)


### Root composer.json requires php ~8.0.8 but your php version (7.3.11) does not satisfy that requirement.

> 1. composer install --ignore-platform-reqs
> 
> 2. `"require": {"php": "^7.3|^8.0",.....},`
> 
> 3. ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/PHPUnit/2.png)




## webserver xdebug

### [PhpStrom](https://www.jetbrains.com/phpstorm/promo/?source=google&medium=cpc&campaign=14335686201&gclid=EAIaIQobChMIwcaj0--_8gIVqwaICR0fLQPwEAAYASAAEgKCOPD_BwE)

### install xdebug

#### matching debug-version

> 1. [Installation Wizard](https://xdebug.org/wizard)
> 
> 2. copy phpinfo() information
> 
> 3. Download xdebug-x.x.x.tgz
> 
> 4. Install the pre-requisites for compiling PHP extensions.On your Mac, we only support installations with 'homebrew', and `brew install php && brew install autoconf` should pull in the right packages.
> 
> 5. Unpack the downloaded file with `tar -xvzf xdebug-x.x.x.tgz`
> 
> 6. Run: cd xdebug-x.x.x
> 
> 7. Run: `phpize` (See the [FAQ](https://xdebug.org/docs/faq#phpize) if you don't have `phpize`).
> > As part of its output it should show:
> > > 
		Configuring for:
		...
		Zend Module Api No:      20200930
		Zend Extension Api No:   420200930
		
> 8. If it does not, you are using the wrong phpize. Please follow [this FAQ entry](https://xdebug.org/docs/faq#custom-phpize) and skip the next step.
> > check **xdebug-x.x.x** path
> > > for example: cd /xxxxx/xxxxx/Documents/xdebug-x.x.x/xdebug-x.x.x
> 
> 9. Run: `./configure`
> 
> 10. Run: `make`
> 
> 11. Run `cp modules/xdebug.so /Applications/XAMPP/xamppfiles/lib/php/extensions/no-debug-non-zts-20200930`
> 
> 12. Update `/Applications/XAMPP/xamppfiles/etc/php.ini` and add the line:`zend_extension = xdebug `
> 
> 13. Restart the Apache Webserver

#### conig webserver xdebug

> **配置php.ini**	
> > 		[xdebug]
	zend_extension = xdebug
	xdebug.idekey  = PHPSTROM

#### install steps

> ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/WebServer/1.png)
> 
> ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/WebServer/2.png)
> 
> ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/WebServer/3.png)
> 
> ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/WebServer/4.png)
> 
> ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/WebServer/5.png)
> 
> ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/WebServer/6.png)

### [XAMPP](https://www.apachefriends.org/index.html)




## [Composer](https://getcomposer.org/)


### config PHP version

![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/Composer/2.png)



### [install composer](https://github.com/composer/composer/issues/8679)
 
> **Global install composer**
> > `sudo mv composer.phar /usr/local/bin/composer`
> 
> **创建composer.json**
> >  1. 切换到当前项目地址执行命令 
> >   
> >  2. `curl -sS https://getcomposer.org/installer | php` **or** `php composer.phar install`
> > 
> >  
> >  3. `php composer.phar init`  生成 composer.json 
> > > **特殊注意如下图**
> > > >  ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/Composer/1.png)
> > 
> >     
> > 		{
		   "name": "test/development",
		    "type": "project",
		    "autoload": {
		        "psr-4": {
		            "test\\Development\\": "src/"
		        }
		    },
		    "authors": [
		        {
		            "name": "***********",
		            "email": "**********"
		        }
		    ],
		    "require": {
		        "php": "~7.2",
		    },
		    "require-dev": {
		        "phpunit/phpunit": "9.5.8"
		        "monolog/monolog": "2.0.*"
		    }
	}
> > > 




## [PHPUnit](https://phpunit.readthedocs.io/en/9.5/)

### config php.ini

	memory_limit=-1
	error_reporting=-1
	log_errors_max_len=0
	zend.assertions=1
	assert.exception=1
	xdebug.show_exception_trace=0

### install PHPUnit

> `composer install`
> >
> > ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/PHPUnit/1.png)
> > 
> > ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/PHPUnit/2.png)
> > 
> > ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/PHPUnit/4.png)