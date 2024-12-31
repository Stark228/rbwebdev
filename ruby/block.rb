# class Config
#   attr_accessor :asset_path
#   def initialize
#     @asset_path = "asset_path"
#   end
#   def configure
#     yield(self) if block_given?
#   end
# end
# config = Config.new
# # p config.asset_path

# config.configure { |cfg|
#   cfg.asset_path = 'new_path'
# }
 
# p config.asset_path

###########################################################

# def my_each(arr)
#   for i in arr
#     yield(i)
#   end
# end

# arr = [1,2,3,4,5]

# my_each(arr) { |r|
#   p r
# }

###########################################################

class FileProcessor
  def process_file(filename)
    File.foreach(filename) do |line|
      yield(line)
    end
  end
end

processor = FileProcessor.new

filename = 'file.txt'

processor.process_file(filename) do |line|
  puts "Line: #{line}"
  word_count = line.split.size
  puts "Word count: #{word_count}"
end


