#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

lessons_url = ARGV[0]
data = open(lessons_url).read
links = data.scan(/https[^"]*\.m3u8/)
output_dir = lessons_url.split('/').last

Dir.mkdir(output_dir) unless File.exists?(output_dir)
Dir.chdir(output_dir)

links.each_with_index do |link, index|
  outname = "#{index + 1}-#{link.split('/').last.split('-')[0..-2].join('-')}.mp4"
  system("youtube-dl #{link} -o #{outname}")
end
