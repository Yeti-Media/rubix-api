module Anakin
  class OCR < Base
     
    protected 

    def build_response(output)
      begin
        resp = JSON.parse(output)
        resp['scenario_url'] = @options[:scenario].file.url
        resp
      rescue JSON::ParserError
        {'scenario_url' => @options[:scenario].file.url}
      end
    end

    def build_specific_args
      args = "-ocr "
      args += " #{@options[:scenario].file.current_path} "
      args += " -rois #{@options[:flags][:rectangles].flatten.join(' ')} " if @options[:flags][:rectangles].present?
      args += " -clearEvery " if @options[:flags][:clear].present?
      args
    end

    def build_common_args
      ""
    end

  end
end
