require 'open-uri'
require 'uri'
require 'net/http'
require 'nokogiri'

# Known Issues
# Need to implement an Upsert solution
# Rescue Exceptions
# Handle Missing HTTP/HTTPS 

class Api::PageImporter

	attr_accessor :errors

	TAGS = ['h1', 'h2', 'h3', 'a']

	def initialize(url)
		self.errors = []
		@url = url

		# We use find or create to keep our tags up to date.
		@url_record = Url.find_or_create_by(address: @url)
		if @url_record.valid?
			# BUILD TAGS
			build_tags 
		else
			self.errors = (@url_record.errors.full_messages.join(","))
		end
	end

	def build_tags
	
		# Where should we check for http/https ?
		# Should we return an error when the website is http?

		# Handle redirect forbiden and other exceptions, begin rescue end.


		# page = Nokogiri::HTML(open("https://" + @url))
		page = Nokogiri::HTML(open(@url))

		TAGS.each do |tag|
			page.xpath("//" + tag).each do |element|
				text = element.text.force_encoding('iso8859-1').encode('utf-8')
				tag = @url_record.tags.find_or_initialize_by(element: tag, content: text).save
			end
		end
		
	end

	# def push_required_field_error(message = 'Something went wrong')
 #    # @errors = [] if @errors.nil?
 #    @errors << message
 #  end

end