module Stylish
  module Fs

    ExtensionsMap = {
      slim: ".html.slim",
      erb: ".html.erb",
      haml: ".html.haml",
      markdown: ".html.md",
      html: ".html",
      coffeescript: ".coffee",
      sass: ".sass",
      scss: ".scss",
      less: ".less",
      javascript: ".js",
      css: ".css"
    }

    extend ActiveSupport::Concern

    included do
      attribute :source_language, Symbol
    end

    def save
      file_proxy.open("w+") do |fh|
        fh.write(code)
      end
    end

    def default_extension
      # TODO
      # Should we use Tilt::Template
      ExtensionsMap[source_language]
    end

    # Eventually Could either be a GHFS::File or a normal File
    def file_proxy
      Pathname(path)
    end
  end
end
