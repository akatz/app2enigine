module App2engine
  class FileWriter
    def initialize(path, opts = {})
      @path = path
      @opts = opts
    end

    def call(contents)
      write_contents(File.read(@path), backup_file_path) if @opts[:backup]
      write_contents(contents, @path)
    end

    private
    def backup_file_path
      "#{@path}.old"
    end

    def write_contents(contents, path)
      File.open(path, "w") { |f| f.write(contents) }
    end
  end
end
