# -*- coding: utf-8 -*-
require 'fileutils'
#require 'open-uri'
require 'cgi'
# usage: script dir

# 脚本进入dir，生成文件列表index.html
# 脚本进入dir的第一级子目录，生成对应的文件列表index.html

# dir目录所有文件和目录
# 返回文件名数组
def getFileList 
  Dir.entries('.').sort
end
# 只收集当前目录中的目录名称
# 返回目录名称数组
def getFolderList
  list = Dir.entries('.').reject {|f| !File.directory?(f)}
  list.reject {|d| d == '.' or d == '..'} # 不要用if
end
# 生成url
# 输入 当前目录所有文件名数组
# 输出 当前目录下生成index.html文件
def collectLinks(filenames)
  links = []
  filenames.reject! do |fn| 
    fn == '.' or fn == '..' or fn == 'index.html'
  end # 去掉当前目录，上级目录和index.html(之前运行过本脚本会有已经生成的index.html不应该包括在内)
  filenames.each do |fn|
    url = CGI::escape(fn)
    # url = URI::encode(fn)  在ruby 1.9中会报 URI.escape is obsolete 过时啦
    link = "<li><a href=\"#{url}\">#{fn}</a></li>"
    links << link
  end
  links
end
def writeIndex(links)
  abs_path = Dir.pwd # 返回当前目录的绝对路径
  folder = abs_path.split('/').last # 当前目录的名字
  File.open("#{abs_path}/index.html", "w") do |f|
    f.puts "<h1>#{folder}</h1>"
    f.puts "<ul id=\"index_page\">"
    f.puts links
    f.puts "</ul>"
    f.puts "<div id='footer'><a href=\"/\">主页</a>/</div>"
  end
end
# 进入、处理和退出子目录
# 只是进入一级目录
def enterAndExit(dirname)
  Dir.chdir(dirname)
  writeIndex(collectLinks(getFileList)) # 生成最高一级目录的index.html
  Dir.chdir('..')
end
def main 
  inputDir = ARGV[0].sub('/','') # de-slashing
  Dir.chdir(inputDir)
  getFolderList.each do |folder|
    enterAndExit(folder)
  end
end
# 开始工作吧 ：）
main()
