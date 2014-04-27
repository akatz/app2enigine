module App2engine
  class FileParser
    def initialize(path)
      @path = path
    end

    def to_a
      file_string_without_requires
    end

    def requires
      @requires ||= file_string.shift(index_of_top_level_namespace)
    end

    private

    def file_string
      @file_string ||= File.readlines(@path)
    end

    def file_string_without_requires
      requires
      file_string
    end

    def index_of_top_level_namespace
      file_string.index { |x| x =~ /class|module/ }
    end
  end
end
