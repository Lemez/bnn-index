class Score < ActiveRecord::Base

	scope :find_by_source, -> (paper) { where(:source => paper) }
	# scope :by_date, -> (needful_date) { where('date.formatted_date = ?', needful_date) }

	def self.from_day(day)
		self.where('created_at > ?', day)
	end

	def formatted_date
		date.formatted_date
	end

	def self.sort_by_date
		self.order('date')
	end

	def self.on_date(d)
		self.select{|b| b.date.formatted_date == d}
	end

end
