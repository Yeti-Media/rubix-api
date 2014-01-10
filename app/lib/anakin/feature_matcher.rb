module Anakin
  class FeatureMatcher < Base

    protected

    def build_response(output)
      begin
        resp = JSON.parse(output)
        resp['scenario_url'] = @options[:scenario].file.url
        resp['values'].map! do |value|
          pattern = Pattern.find_by_aid(value['label'])
          value['pattern_url'] = pattern.file.url
          value['label'] = pattern.label
          value
        end
        resp
      rescue JSON::ParserError
        {'scenario_url' => @options[:scenario].file.url}
      end
    end

    def pattern_dir
      File.join(Rails.root, "public", "uploads", "pattern", @options[:user].id.to_s, 'matching')
    end

    def build_specific_args
      args = ""
      args += " -mma #{@options[:flags][:mma]} " if @options[:flags][:mma].present?
      args += " -mr #{@options[:flags][:mr]} " if @options[:flags][:mr].present?
      args
    end

  end
end
