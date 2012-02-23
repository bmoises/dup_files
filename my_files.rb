require "rubygems"
require "bundler/setup"

$: << File.expand_path(File.dirname(__FILE__))
require 'lib/my_files'
require 'lib/db'
require 'lib/processor'
require 'constants'


proc     = Processor.new
proc.db  = Db.new(DB_FILE)
my_files = MyFiles.new(ARGV)

my_files.files do |file|
  proc.process(file)
end

