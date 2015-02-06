module Anakin
  class OCR < Client
       
    def ocr(body)
      image_path = body[:scenario].file.tmp_path
      image_type = body[:flags][:image_type] || "document"
      if image_type == "document"
        # Stick with the document-based OCR users are presumably familiar with.
        # NOTE: This is running OCR directly on the API-serving host.
        ocr_command = File.join(Rails.root, 'bin', 'anakin')
        command = "#{ocr_command} -ocr #{image_path}"
        Rails.logger.info command
        shell = Mixlib::ShellOut.new(command)
        shell.run_command
        result = shell.stdout
      else
        # Call the scene-text detection OCR.
        # NOTE: This continues to run OCR directly on the API-serving host,
        # but we move it to a separate daemon since the scene-detection
        # library has a longish start-up cost.
        result = perform({ action: "ocr", ocr: image_path },
                         "scene_text_ocr")
        # Anakin OCR result format seems to have changed from what was last
        # deployed, and become reduntantly nested. Remove that surprise here.
        if result.respond_to? "values"
          values = result["values"][0]
          result = values if values.respond_to? "values"
        end
      end
      Rails.logger.info result
      result
    end

  end
end
