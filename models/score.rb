class Score < ActiveRecord::Base

	scope :find_by_source, -> (paper) { where(:source => paper) }

	def formatted_date
		self.date.formatted_date
	end

end
