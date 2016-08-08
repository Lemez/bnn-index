class Story < ActiveRecord::Base

	scope :express, -> { where(source:"express") }
	scope :guardian, -> { where(source:"guardian") }
	scope :independent, -> { where(source:"independent") }
	scope :mail, -> { where(source:"mail") }
	scope :telegraph, -> { where(source:"telegraph") }
	scope :times, -> { where(source:"times") }
	scope :find_by_source, -> (paper) { where(:source => paper.downcase) }
	scope :negative, -> { where('mixed < ?', 0) }

	def self.today
		self.select{|b| b.date.formatted_date == Date.today.to_s}
	end

	def self.from_day(day)
		self.where('created_at > ?', day)
	end

	def self.from_today
		self.where('created_at > ?', Date.today)
	end

	def self.on_date(d)
		self.select{|b| b.date.formatted_date == d}
	end

	def formatted_date
		self.date.formatted_date
	end

	def pretty_date
		self.date.pretty_date
	end


end
