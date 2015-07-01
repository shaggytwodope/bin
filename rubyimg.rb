#!/usr/bin/env ruby
# Text File
# AUTHOR:   shaggy
# FILE:     rubyimg.rb
# ROLE:     TODO (some explanation)
# CREATED:  2015-06-29 19:35:05
# MODIFIED: 2015-06-29 19:35:09
require "tco"
require "rmagick"

img = Magick::Image::read(ARGV[0]).first
img.each_pixel do |pixel, col, row|
  c = [pixel.red, pixel.green, pixel.blue].map { |v| 256 * (v / 65535.0) }
  pixel.opacity == 65535 ? print("  ") : print("  ".bg c)
  puts if col >= img.columns - 1
end
