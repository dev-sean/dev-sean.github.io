#!/usr/bin/env ruby

require 'date'
require 'time'
require 'fileutils'

# 명령줄 인자 파싱
title = ARGV[0] || "Untitled"
date = Date.today.strftime('%Y-%m-%d')
date_time = Time.now.strftime('%Y-%m-%d %H:%M:%S %z')
slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
filename = "_posts/#{date}-#{slug}.md"

# 템플릿 파일 읽기
template_path = File.expand_path("../_templates/leetcode.md", __dir__)
if File.exist?(template_path)
  template_content = File.read(template_path)
else
  puts "Template file not found at #{template_path}"
  exit
end

# 새 포스트 파일 생성
FileUtils.mkdir_p('_posts')
File.open(filename, 'w') do |file|
  file.puts "---"
  file.puts "layout: post"
  file.puts "author: <sean>"
  file.puts "title: \"LeetCode {Number}: {Title-En} ({Title-Ko})\""
  file.puts "date: #{date_time}"
  file.puts "categories: [코딩 테스트, LeetCode]"
  file.puts "tags: [코딩 테스트]"
  file.puts "description: "
  file.puts "---"
  file.puts template_content
end

puts "Created new post at #{filename}"
