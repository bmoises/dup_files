class Excludes
  include Singleton
  
  attr_accessor :file, :exclusions 
  def setup(file)
    @file = file
    exclusions = []
    
    File.open(file).each_line do |line|
      exclusions << line
    end
    @exclusions = exclusions.to_set
  end
  
  def exclude?(elem)
    @exclusions.include?(elem)
  end
end