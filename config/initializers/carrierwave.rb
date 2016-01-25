CarrierWave.configure do |config|
	config.storage = :fog
	config.fog_credentials = {
		:provider => nil,
		:rackspace_username => nil,
		:rackspace_api_key => nil,
		:rackspace_region => :iad
	}
	if Rails.env.development?
		config.fog_directory = nil
	elsif Rails.env.production?
		config.fog_directory = nil
	end
	#config.fog_public = false
end