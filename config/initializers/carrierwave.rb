CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJPPJMAKTH2CWFFGA',                        # required
    :aws_secret_access_key  => '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',
    :path_style            => true
  }
  config.fog_directory  = 'assets.rubix.io'                     # required
  config.fog_public     = true 
  config.asset_host = "//assets.rubix.io.s3.amazonaws.com" 
  config.fog_authenticated_url_expiration = 600                              # optional, defaults to true
  config.fog_attributes = {'x-amz-server-side-encryption' => 'AES256','Cache-Control'=>'max-age=315576000'} 
end