---
title: hexo疑难杂症
date: 2018-05-11 20:59:10
tags: hexo
---

# 问题

## deploy

### ERROR Deployer not found: git
	
> * npm install hexo --save
> * npm install --save hexo-deployer-git
> * npm install hexo-server
> 
> * npm ls --depth 0 查看npm安装各hexo插件情况
> > * npm install hexo-generator-archive@^0.1.4
> > * npm install hexo-generator-category@^0.1.3
> > * npm install hexo-generator-index@^0.2.0
> > * npm install hexo-generator-tag@^0.2.0
> > * npm install hexo-renderer-ejs@^0.3.0
> > * npm install hexo-renderer-marked@^0.3.0
> > * npm install hexo-renderer-stylus@^0.3.1

### 目录全部内容都提交上去,真正部署只是public文件夹内容

> * 在hexo根目录,将.deploy_git文件夹删除即可
> * hexo g
> * hexo d

### WARN  No layout: index.html

查看**根目录themes**是否有主题文件,例如:next、jacman


