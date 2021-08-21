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


## webserver xdebug

### [PhpStrom](https://www.jetbrains.com/phpstorm/promo/?source=google&medium=cpc&campaign=14335686201&gclid=EAIaIQobChMIwcaj0--_8gIVqwaICR0fLQPwEAAYASAAEgKCOPD_BwE)


#### conig webserver xdebug

> **配置php.ini**	
> > 		[PHPUnit]
		memory_limit=-1
		error_reporting=-1
		log_errors_max_len=0
		zend.assertions=1
		assert.exception=1
		xdebug.show_exception_trace=0


### [XAMPP](https://www.apachefriends.org/index.html)



## 


## [Composer](https://getcomposer.org/)


### config PHP version

![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/Composer/2.png)



### install composer
 
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
>  
> 
> 
> 




## [PHPUnit](https://phpunit.readthedocs.io/en/9.5/)


> **安装PHPUnit**
> > `composer install`
> > >
> > > ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/PHPUnit/1.png)
> > > 
> > > ![](/images/php/PhpStrom+Composer+PHPUnit+XAMPP/PHPUnit/2.png)









