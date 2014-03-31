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
      Rails.logger.info("==== EXTRACTOR RUNNING ====")
      command = "#{extractor_command} -#{self.mode} -iFile #{self.pattern.file.path} -toJson -xml"
      Rails.logger.info(command)
      shell = Mixlib::ShellOut.new(command)
      shell.run_command
      result = shell.stdout
      Rails.logger.info("Result")
      result = Yajl::Parser.parse(result)
      Rails.logger.info(result)
      result
    end

  end
end