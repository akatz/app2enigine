require 'thor'
require 'app2engine/file_writer'
require "app2engine/file_converter"

module App2engine
  class Cli < Thor
    desc 'convert', 'converts a file to an engine namespace'
    def convert(file)
      FileWriter.new(file, backup: true).call(FileConverter.new(file).call)
      true
    end
  end
end
