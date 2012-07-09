# -*- coding: utf-8 -*-
require 'fileutils'
require 'html2markdown'


# usage: script inputfile outputfile
=begin
ref: https://github.com/29decibel/html2markdown

p = HTMLPage.new :contents => '<strong>haha</strong>'
p.markdown.should == '**haha**'
p.contents = '<strong>hehe</strong>'
p.markdown!.should == '**hehe**'

=end

inputfile = ARGV[0]
outputfile = ARGV[1] 

str = File.open(inputfile).read
raw_html = HTMLPage.new :contents => str # 复数 contents
mdwn = raw_html.markdown
# p mdwn

File.open(outputfile, 'w') do |f|
  f.puts mdwn
end



