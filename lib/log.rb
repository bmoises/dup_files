class Log
  def info(stuff)
    write "INFO: #{stuff}"
  end
  
  def warn(stuff)
    write "WARN: #{stuff}"
  end
  
  def verbose(stuff)
    write "VERBOSE: #{stuff}"
  end
  
  def write(stuff)
    puts stuff if ENV['VERBOSE']
  end
end