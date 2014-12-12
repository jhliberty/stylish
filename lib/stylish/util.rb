module Stylish
  module Util
    def self.deserialize(path, format=nil)
      path = path.to_pathname

      contents = path.read

      if format.nil?
        format = "yml" if path.extname.downcase == ".yml"
        format = "json" if path.extname.downcase == ".json"
      end

      if format == "json"
        JSON.parse(contents)
      elsif format == "yaml" || format == "yml"
        YAML.load(contents)
      end
    end
  end
end
