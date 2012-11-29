require 'open-uri'

module Fletch
  class File
    def initialize(library, attributes)
      attributes.slice!(:url, :path, :replace)

      @library = library
      @url = attributes[:url]
      @path = attributes[:path]
      @replace = attributes[:replace]
    end

    def interpolated_url
      @replace.reduce(@url) do |processed_url, replacement|
        matcher, replace_with = replacement
        processed_url.gsub(matcher, eval(replace_with))
      end
    end

    def content
      @content ||= open(interpolated_url).read
    end

    def write
      open(@path, 'wb') do |file|
        file << content
      end
    end
  end
end
