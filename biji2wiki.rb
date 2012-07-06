# -*- coding: utf-8 -*-

# 使用方法 ruby script.rb inputfile output-folder
# 笔记是用markdown格式写的。每一个h1标题代表一篇文章
# 本脚本分割笔记文件到每篇文章一个文件


def sanitize(title)
  # 不要空格
  # 所有键盘上可以按出来的标点符号，中文和英文的我都替换掉
  # 中文标点所有 http://zh.wikipedia.org/zh/%E6%A0%87%E7%82%B9%E7%AC%A6%E5%8F%B7
  # http://www.ruanyifeng.com/blog/2007/07/english_punctuation.html
  title.tr!(' `~!@#$%^&*()_+=\|][{}"\';:/?.>,<', '_')
  title.tr!('·～！@#￥%……&*（）——+、|】』【『‘“；：/？。》，《', '_')
  title.gsub!(/_+/, '_')
  title.gsub!(/^_+/, '') #如果前几个字符是下划线，去除
  title.gsub!(/_+$/, '') #如果最后几个字符是下划线，去除
end


file = ARGV[0]
output_folder = ARGV[1]
#file = File.open('./biji.txt', 'r')
str = IO.read(file)
arr = str.split(/^# /)
#arr的第一个元素 \n
#irb(main):014:0> arr.shift
#=> "\n"
arr.shift
arr.each do |article| 
  #每个article的第一行是题目
  fn = article.split(/\n/)[0]
  sanitize(fn)
  #把题目的h1标题写回去。 \A 表示整个字符串的开始
  article.sub!(/\A/, '# ') 
  File.open("#{output_folder}/#{fn}", 'w') do |f|
    f.puts article
  end
end
