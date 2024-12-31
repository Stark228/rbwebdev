module Utilities
  class FileHandler
    def self.read(file)
      puts "Reading from #{file}..."
    end

    def self.write(file, content)
      puts "Writing to #{file}..."
      puts content
    end
  end
end

Utilities::FileHandler.read("example.txt")
Utilities::FileHandler.write("example.txt", "This is a test.")
