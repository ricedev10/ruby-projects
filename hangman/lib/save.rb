require 'json'
require 'pathname'

class Save
  attr_reader :saves

  def initialize(dir)
    Dir.mkdir(dir) unless Dir.exist?(dir)
    @dir = Pathname(dir).realpath
    @relative_dir = @dir.relative_path_from(Pathname(__FILE__).realpath)
    @saves = []

    load_saves
    p @dir
    p @relative_dir
  end

  def add_save(obj)
    raise(TypeError) unless obj.is_a?(Hash)

    @saves << obj
  end

  def serialize
    @saves.each_index do |i|
      @saves[i]['dir'] = @relative_dir
      content = JSON.dump(@saves[i])
      File.write(File.join(@dir, "#{i}.json"), content)
    end
  end

  def deserialize(path)
    obj = JSON.parse(File.read(path))
    return unless obj.is_a?(Hash) && obj['dir']

    @saves << obj if Pathname.new(obj['dir']) == @relative_dir
  rescue JSON::ParserError
    puts "Could not parse json: #{path}"
  end

  def load_saves
    Pathname(@dir).each_child do |child_dir|
      deserialize(child_dir)
    end
  end
end
