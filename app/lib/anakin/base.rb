module Anakin
  class GeneralError < Exception
  end

  class ArgumentError < Exception

  end

  class Base

    #{user: user, scenario: scenario, type: 'ocr', flags: [:custom]}
    def initialize(options)
      @options = options
    end

    def valid?
      validate
    end

    def process!
      if valid?
        build_response(run)
      else
        raise ArgumentError , "Invalid Arguments"
      end
    end
    
    protected 

    def run
      command = build_command
      Rails.logger.info("====== ANAKIN RUNNING =======")
      Rails.logger.info command
      anakin = Mixlib::ShellOut.new command
      anakin.run_command
      Rails.logger.info("====== ANAKIN STDOUT  =======")
      Rails.logger.info anakin.stdout
      Rails.logger.info("====== ANAKIN STDERR  =======")
      Rails.logger.info anakin.stderr
      Rails.logger.info("====== ANAKIN ENDED   =======")
      if anakin.stderr.empty?
        anakin.stdout
      else
        raise Anakin::GeneralError, anakin.stderr
      end
    end

    def build_command
      "#{File.join(Rails.root, 'bin', 'anakin')} #{build_args}" 
    end

    def build_args
      build_common_args + build_specific_args
    end

    def build_common_args
      "-s #{@options[:scenario].file.current_path} -p #{pattern_dir}"
    end

    def build_specific_args
      ""
    end

    def build_response
      ""
    end

    def pattern_dir
      ""
    end

    def validate
      true
    end
     
  end
end
