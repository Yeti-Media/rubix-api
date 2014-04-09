module Anakin
  class OCR < Client
       
    def ocr(body)
      ocr_command = File.join(Rails.root, 'bin', 'anakin')
      command = "#{ocr_command} -ocr #{body[:scenario].file.tmp_path}"
      Rails.logger.info command
      shell = Mixlib::ShellOut.new(command)
      shell.run_command
      result = shell.stdout
      Rails.logger.info result
      result
    end

  end
end
