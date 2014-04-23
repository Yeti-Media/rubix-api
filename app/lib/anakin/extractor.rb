module Anakin
  class Extractor

    attr_accessor :mode, :pattern

    def initialize(mode, pattern)
      self.mode = mode
      self.pattern = pattern
    end

    def extract!
      extract
    end


    private

    def extract
      extractor_command = File.join(Rails.root, 'bin', 'extractor')
      command = "#{extractor_command} -#{self.mode} -iFile #{self.pattern.file.path} -toJson -xml"
      shell = Mixlib::ShellOut.new(command)
      shell.run_command
      result = shell.stdout
      result = Yajl::Parser.parse(result)
      result
    end

  end
end