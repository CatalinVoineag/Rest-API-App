class Api::V1::PagesController < Api::BaseController

	def index
		@urls = Url.all

		output = {url_count: @urls.count, urls: @urls.map { |u| u.api_export }}

		respond_to do |format|
      format.json { render json: output, status: status }
    end
	end

	def store_content
		# check if params[:url] is present
		page_importer = Api::PageImporter.new(params[:url])
		message, status = "", 0

		if !page_importer.errors.present?
			status = 200
			message = "Content Indexed"
		else
			status = 500
			message = page_importer.errors
		end

		output = {message: message}

		respond_to do |format|
      format.json { render json: output, status: status }
    end
	end

end