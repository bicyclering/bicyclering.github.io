#! /bin/zsh

cd /Users/willson/Documents/github/bicyclering.github.io
rm -rf .deploy_git
hexo clean
hexo generate
hexo server
