module Anakin
  class Histogram < Comparison

    protected 

    def build_response(output)
      begin
        resp = JSON.parse(output)
        resp['scenario_url'] = @options[:scenario].file.url
        resp['matches'].map! do |value|
          pattern = Pattern.find_by_aid(value['pattern'])
          value['pattern_url'] = pattern.file.url
          value['label'] = pattern.label
          value
        end
        resp
      rescue JSON::ParserError
        {'scenario_url' => @options[:scenario].file.url}
      end
    end

    def build_specific_args
      args = ""
      args += super
      args += " -#{@options[:flags][:method]} " if @options[:flags][:method].present?
      if @options[:flags][:type].present?
        args += " -h#{@options[:flags][:type].humanize} " 
      else
        args += " -h " 
      end
      args
    end

  end
end