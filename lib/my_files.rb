$: << File.expand_path(File.dirname(__FILE__))

require 'find'
require 'set'
require 'singleton'

require 'log.rb'
require 'excludes.rb'
require 'pp'

class MyFiles
  attr_accessor :initial_path, :excludes_file, :excludes
  attr_accessor :log
  attr_accessor :files, :directories
  def initialize(args)
    @initial_path, @excludes_file = args
    
    @log = Log.new
    
    @excludes = Excludes.instance
    @excludes.setup(@excludes_file)
    @files, @directories = [], []
  end
  
  def files
    # Init with the initial contents of initial_path
    directory_contents(initial_path)
    while true
      @log.warn "Files: #{@files.size} -- Directories: #{@directories.size}"
      # stopping condition is , @files and @directories must have size zero
      if @files.size == 0 && @directories.size == 0
        break
      end
      # process files
      while file = @files.shift do
        @log.info file
        yield file
      end
      # process 1 directory at a time
      directory_contents(@directories.shift)
    end
  end
  
  private
  
    def directory_contents(path)
      if !path
        @log.warn "path is emtpy"
        return
      end
      @log.verbose "Path: #{path}"
      Dir[(path+"/*")].each do |loc| 
        #puts loc
        if skip?(loc)
          @log.warn "Skipping: #{path}"
          next
        end
        if FileTest.directory?(loc)
          puts "Processing: #{loc}"
          @directories << loc
        else
          @files << loc
        end
      end
    end
    
    def skip?(path)
      @excludes.exclude?(File.basename(path))
    end
    
    def initial_path
      @initial_path
    end
end