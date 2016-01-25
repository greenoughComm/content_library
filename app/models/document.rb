class Document < ActiveRecord::Base
	
	validates :title, presence: true, uniqueness: true
	validates :specialty, presence: true
	validates :business_type, presence: true
	validates :document_type, presence: true
	validates :facility_type, presence: true
	validates :state, presence: true

	mount_uploader :file, FileUploader

	def get_url

		file = self.file.to_s

		if Rails.env.development?
			directory = 'content_library_development'
		elsif Rails.env.production?
			directory = 'content_library_production'
		end

		temp_url = FOG_CONNECTION.get_object_https_url(directory, file, Time.now + 600)

		return temp_url

	end

end