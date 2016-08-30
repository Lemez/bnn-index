class Score < ActiveRecord::Base

	scope :find_by_source, -> (paper) { where(:source => paper) }
	scope :express, -> { where(source:"express") }
	scope :guardian, -> { where(source:"guardian") }
	scope :independent, -> { where(source:"independent") }
	scope :mail, -> { where(source:"mail") }
	scope :telegraph, -> { where(source:"telegraph") }
	scope :times, -> { where(source:"times") }
	# scope :by_date, -> (needful_date) { where('date.formatted_date = ?', needful_date) }

	def self.from_day(day)
		self.where('created_at > ?', day)
	end

	def self.from_today
		self.where('created_at > ?', Date.today)
	end

	def formatted_date
		date.formatted_date
	end

	def self.sort_by_date
		self.order('date')
	end

	def self.on_date(d)
		@date = Date.parse(d)
		self.where(created_at: @date..(@date + 1.day))
	end

	def is_valid?
		!first.score.nil? && !first.score.nan?
	end

end
