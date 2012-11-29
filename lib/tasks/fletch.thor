class Fletch < Thor
  desc 'fetch', 'fetch assets as defined in fletch.json'
  def fetch
    fetch_files
  end

  no_tasks do
    def fetch_files
      yaml.each do |library, options|
        Fletch::File.new(library, options).write
      end
    end

    def yaml
      @yaml ||= JSON.parse(File.open("fletch.json", "rb").read).symbolize_keys
    end
  end
end
