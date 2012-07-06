# -*- coding: utf-8 -*-

require 'fileutils'
#require 'yaml'

=begin

## 我笔记的文件格式
就是个文本文件，markdown格式

        # 一篇文章标题
        正文正文正文正文正文正文正文正文正文
        # 又一篇文章
        正文正文正文正文正文正文正文正文
        
好处是我随时想写打开这个文本文件可就可以了。现在我需要让程序把它切分为每篇文章一个文件。使用ruby。

## 思路：
1. 打开整个文件
1.  /^# / 作为分割符 把整个文本差分成数组。遍历数组，每个写成一个文件。
  
=end

file = ARGV[0]

# 读入文件到字符串并处理
str = IO.read(file)
posts = str.split(/^# /)
posts.shift 

=begin
获取时间并转换为jekyll可用的字符串形式
>> Time.new.to_s
=> "2012-05-18 14:14:04 +0800"
>> Time.new.to_s[0,10]
=> "2012-05-18"
=end
date = Time.new.to_s[0,10]

counter = 0 # 为了让filename不重复

posts.each do |post|

  counter += 1

  title = post.split(/"\n"/)[0] # 文章标题就是post的第一行
  body = post.split(/"\n"/)
  body = body.shift # 文章正文就是post去掉的第一行

  frontmatter = {
    'layout' => 'post',
    'title' => title,
    'created' => date,
    'date' => date
  }.to_yaml
  
  filename = "#{date}-#{counter}.markdown"
  File.open("#{filename}", "w") do |f|
    f.puts frontmatter # 不许要开始的 "----" 因为 to_yaml 方法会加上
    f.puts "---"
    f.puts body
  end
end
