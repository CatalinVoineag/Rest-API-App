require 'uri'

class Url < ApplicationRecord

	has_many :tags, dependent: :destroy

	validates :address, presence: true, uniqueness: { case_sensitive: false }

	validates :address, url: true

	# validate :check_if_url_correct

	# def check_if_url_correct
	# 	byebug
 #  	uri = URI.parse(self.address) && !uri.host.nil?
	# 	rescue 
 #  	self.errors.add(:url, "is not valid")
	# end

	def api_export
		{
			:url => self.address
		}.merge(import_tags)
	end

	def import_tags
		tag_hash = {}
		tag_hash = Hash.new{|hsh,key| hsh[key] = [] }

		self.tags.each do |tag| 
			tag_hash[tag.element.to_sym].push(tag.content) 
		end
		return tag_hash 
	end


end
