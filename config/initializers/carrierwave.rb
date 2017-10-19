require 'fog/aws'
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Figaro.env.AWS_ACCESS_KEY_ID,
    aws_secret_access_key: Figaro.env.AWS_SECRET_ACCESS_KEY,
    region:                'eu-central-1'
  }
  config.fog_directory  = Figaro.env.S3_BUCKET_NAME

end