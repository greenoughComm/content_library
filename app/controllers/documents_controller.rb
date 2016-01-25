class DocumentsController < ApplicationController
	before_action :authenticate_user!

	def index
		@documents = Document.all
	end

	def show
		@document = Document.find(params[:id])
		render action: "show"
	end

	def new
		@document = Document.new
		authorize! :create, @document
	end

	def edit
		@document = Document.find(params[:id])
		authorize! :edit, @document
	end

	def create
		@document = Document.new(document_params)
		
		if @document.save
			@documents = Document.all
			render action: "index"
		else
			render action: "new"
		end
	end

	def update
		@document = Document.find(params[:id])

		if @document.update(document_params)
			redirect_to action: "index"
		else
			render 'edit'
		end
	end

	def destroy
		@document = Document.find(params[:id])
		@document.destroy

		redirect_to documents_path
	end

private
	def document_params
		params.require(:document).permit(:title, :specialty, :business_type, :document_type, :facility_type, :state, :file)
	end
end
