CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV["amazon_access_key"],
      :aws_secret_access_key  => ENV["amazon_secret"],
      :region                 => 'ap-southeast-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  # Please take note of the region problem or else you will get the SSL:Open Error
  config.fog_directory  = "v3-homebnb"
end