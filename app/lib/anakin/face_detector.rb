module Anakin
  class FaceDetector < Client
       
    def detect_face(body)
      image_path = body[:scenario].file.tmp_path
      result = perform({ 
                         action: "detect_face", 
                         img: image_path,
                         original_width: body[:scenario].file.original_width,
                         original_height: body[:scenario].file.original_height
                       },
                       "detect_face")
      Rails.logger.info result
      result
    end

  end
end
