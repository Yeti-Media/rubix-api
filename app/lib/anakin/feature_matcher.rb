module Anakin
  class FeatureMatcher

    def initialize(user, scenario)
      @user = user
      @scenario = scenario
    end

    def match!
      build_response(run)
    end

    private

    def run
      Rails.logger.info("====== ANAKIN RUNNING =======")
      Rails.logger.info("#{File.join(Rails.root, 'bin', 'anakin')} -s #{@scenario.file.current_path} -p #{pattern_dir}")
      anakin = Mixlib::ShellOut.new("#{File.join(Rails.root, 'bin', 'anakin')} -s #{@scenario.file.current_path} -p #{pattern_dir}")
      anakin.run_command
      Rails.logger.info("====== ANAKIN STDOUT  =======")
      Rails.logger.info anakin.stdout
      Rails.logger.info("====== ANAKIN ENDED   =======")
      anakin.stdout
    end

    def build_response(output)
      resp = JSON.parse(output)
      resp['scenario_url'] = @scenario.file.url
      resp['values'].map! do |value|
        pattern = Pattern.find_by_aid(value['label'])
        value['pattern_url'] = pattern.file.url
        value['label'] = pattern.label
        value
      end
      resp
    end

    def pattern_dir
      File.join(Rails.root, "public", "uploads", "pattern", @user.id.to_s)
    end

  end
end
