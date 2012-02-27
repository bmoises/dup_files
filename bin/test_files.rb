require 'fileutils'


tmp_dir = File.join(File.dirname(__FILE__),"..","tmp_files")

FileUtils.rm_r tmp_dir

patterns = [
  "010101010101",
  "001001001001",
  "100100100100",
  "111111111111",
  "000000000000",
  "abababababab",
  "cdcdcdcdcdcd"
  ]


def write_file(file,content,numtimes)
  File.open(file,"w") do |file|
    (0..numtimes).each{ file.puts content }
  end
end

patterns.each do |pattern|
  dir = File.join(tmp_dir,pattern)
  FileUtils.mkdir_p dir
  
  (0..3).each {
    p = patterns[rand(patterns.size)]
    write_file(File.join(dir,p+".txt"),p,65536)
  }
end


puts "Feed to code: #{tmp_dir}"