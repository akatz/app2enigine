require 'thor'
require 'app2engine/file_writer'
require "app2engine/file_converter"

module App2engine
  class FileList
    def initialize(path)
      @files = []
      if File.directory?(path)
        @files += Dir.glob("#{path}/**")
      else
        @files += [path]
      end
      @files.reject! { |file| File.directory?(file) }
    end

    def each(&block)
      @files.each(&block)
    end
  end
  class Cli < Thor
    desc 'convert', 'converts a file to an engine namespace'
    def convert(path)
      FileList.new(path).each do |file|
        FileWriter.new(file, backup: true).call(FileConverter.new(file).call)
      end
      true
    end
  end
end
