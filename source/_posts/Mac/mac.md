---
title: mac
tags: mac
categories: Mac
date: 2021-09-24 14:19:22
---

# Mac

## [mac ssh Unable to negotiate](https://www.volico.com/wiki/pages/viewpage.action?pageId=15728687)
 
> 1. enter to /etc/ssh/ssh_config
> > HostkeyAlgorithms +ssh-dss
> > 
> > KexAlgorithms +diffie-hellman-group1-sha1
> > 
> > Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc
> 
> 2. ssh-keygen -R xxx.xxx.xxx.xxx
> 
> 3. ssh-rsa copy to ~/.ssh/known_hosts
