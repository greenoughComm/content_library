FOG_CONNECTION = Fog::Storage.new(:rackspace_username     => nil,
	                            :rackspace_api_key      => nil,
	                            :rackspace_region	   => nil,
	                            :provider               => nil)

account = FOG_CONNECTION.account
account.meta_temp_url_key = nil
account.save

FOG_CONNECTION = Fog::Storage.new(:rackspace_username     => nil,
	                            :rackspace_api_key      => nil,
	                            :rackspace_region	    => nil,
	                            :rackspace_temp_url_key => nil,
	                            :provider               => nil)