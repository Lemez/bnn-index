class Story < ActiveRecord::Base

	scope :express, -> { where(source:"Express") }
	scope :guardian, -> { where(source:"Guardian") }
	scope :independent, -> { where(source:"Independent") }
	scope :mail, -> { where(source:"Mail") }
	scope :telegraph, -> { where(source:"Telegraph") }
	scope :times, -> { where(source:"Times") }
	scope :find_by_source, -> (paper) { where(:source => paper) }

	def self.today
		self.select{|b| b.date.formatted_date == Date.today.to_s}
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
