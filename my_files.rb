require "rubygems"
require "bundler/setup"

$: << File.expand_path(File.dirname(__FILE__))
require 'lib/my_files.rb'

my_files = MyFiles.new(ARGV)

my_files.files

pp my_files.inspect

# 
# file = []
# 
# def list_files(dir)
#   
# end
# Dir[path+'/*'].each do |f| 
#   p f 
# end
# 
# 
#   Find.find(dir) do |path|
#     if FileTest.directory?(path)
#       if excludes.include?(File.basename(path))
#         Find.prune       # Don't look any further into this directory.
#       else
#         next
#       end
#     else
#       p path
#     end
#   end