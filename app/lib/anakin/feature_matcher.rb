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
      Rails.logger.info("====== ANAKIN RUNS=======")
      Rails.logger.info("#{File.join(Rails.root, 'bin', 'anakin')} #{@scenario.file.current_path} #{pattern_dir}")
      system("#{File.join(Rails.root, 'bin', 'anakin')} #{@scenario.file.current_path} #{pattern_dir}")
    end

    def build_response(output)
      JSON.parse(output)
    end

    def pattern_dir
      File.join(Rails.root, "public", "pattern", @user.id.to_s)
    end

  end
end
