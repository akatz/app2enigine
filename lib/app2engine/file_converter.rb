require 'app2engine/file_parser'

module App2engine
  class FileConverter
    def initialize(path)
      @path = path
    end

    def call
      @requires = requires.join
      @contents = string_with_spaces.join
      ERB.new(template).result(binding)
    end

    private

    def requires
      FileParser.new(@path).requires
    end

    def string_with_spaces
      FileParser.new(@path).to_a.map {|line| convert_line(line) }
    end

    def convert_line(line)
      line == "\n" ? "\n" : "  #{line}"
    end

    def template
      "<%= @requires %>module Monorail\n<%= @contents %>end\n"
    end
  end
end
