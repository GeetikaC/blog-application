require 'date'
class Article < ApplicationRecord
	mount_uploader :feature_image_url, CoverUploader

	belongs_to :category

	validates_presence_of :title, :body, :category_id, :publish_date, :feature_image_url
	validate :publish_date_cannot_be_more_than_one_month_from_today, on: [:create, :update]
	validate :publish_date_in_the_past, on: [:create, :update]
	validate :publish_date_in_the_future, on: [:create, :update]

	def publish_date_cannot_be_more_than_one_month_from_today
		if publish_date > Date.today.next_month
			errors.add(:publish_date, "can't be greater than one month from today")
		end
	end

	def publish_date_in_the_past
		if publish_date <= Date.today
			is_published = true
		end
	end

	def publish_date_in_the_future
		if publish_date > Date.today
			is_published = false
		end
	end
end