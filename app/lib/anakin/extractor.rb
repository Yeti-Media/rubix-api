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
      Rails.logger.info "EXTRACTOR COMMAND"
      Rails.logger.info command
      shell.run_command
      Rails.logger.info "OUTPUT"
      Rails.logger.info shell.stdout
      Rails.logger.info shell.stderr
      result = shell.stdout
      result = Yajl::Parser.parse(result)
      result
    end

  end
end