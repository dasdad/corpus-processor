class CorpusProcessor::Categories
  @@instances = Hash.new

  def self.load path
    @@instances[path] ||= YAML.load(File.read(path)).tap { |categories|
      default = categories[:output] && categories[:output][:default]
      if default
        categories[:output].default = default
        categories[:output].delete :default
      end
    }
  end

  def self.default
    self.load(File.expand_path(File.join('..', 'categories', 'default.yml'),
                               __FILE__))
  end
end
