class Time

	def formatted_date
		strftime("%Y-%m-%d")
	end

	def pretty_date
		strftime("%e %b, %Y")
	end

end