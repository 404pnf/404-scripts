# -*- coding: utf-8 -*-
require 'rss/2.0'
require 'open-uri'
require 'fileutils'
require 'yaml'
require './sanitize-title.rb'
# ref: http://rubyrss.com/

file = ARGV[0]
output = ARGV[1]

File.open(file) do |f|
  response = f.read
  result = RSS::Parser.parse(response, false) # false 是说不去validate rss
  puts "Channel: " + result.channel.title
  result.items.each do |item|
    title = item.title.to_s.strip
    mytitle = sanitize(title).gsub(/_/, ' ')
    fn = sanitize(mytitle)
    fn = fn.slice(0,60)
    pubdate = item.date.xmlschema
    # date: 2012-02-16
    date = pubdate.slice(0,10)
    year = pubdate.slice(0,4)

    content = item.description.to_s
    content = content.gsub(/\n/,"\n\n").gsub(/\n\n\n+/,"\n\n")

    # Get the relevant fields as a hash, delete empty fields and convert
    # to YAML for the header
    data = {
    'layout' => 'post',
    'title' => mytitle.to_s,
    }.delete_if { |k,v| v.nil? || v == ''}.to_yaml

    Dir.mkdir(output) if !File.exist?(output)
    Dir.mkdir(year) if !File.exist?(year)

    File.open("#{output}/#{year}/#{date}-#{fn}.markdown", "w:utf-8") do |file|
      #file.puts data
      #file.puts "---"
      #file.puts
      file.puts content
    end

  end      # end each
end # end File.open


