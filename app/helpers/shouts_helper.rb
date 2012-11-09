# encoding: utf-8
module ShoutsHelper
	def display_date(input_date)
		return input_date.strftime("%B %d, %Y")
	end
end
