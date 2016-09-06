class Story < ActiveRecord::Base

	scope :express, -> { where(source:"express") }
	scope :guardian, -> { where(source:"guardian") }
	scope :independent, -> { where(source:"independent") }
	scope :mail, -> { where(source:"mail") }
	scope :telegraph, -> { where(source:"telegraph") }
	scope :times, -> { where(source:"times") }
	scope :mirror, -> { where(source:"mirror") }
	scope :ft, -> { where(source:"ft") }
	scope :find_by_source, -> (paper) { where(:source => paper.downcase) }
	scope :negative, -> { where('mixed < ?', 0) }

	has_many :words

	# require 'similarity'

	def self.today
		self.select{|b| b.date.formatted_date == Date.today.to_s}
	end

	def self.from_day(day)
		self.where('created_at > ?', day)
	end

	def self.since_day(day)
		self.where('created_at > ?', day)
	end

	def self.from_today
		self.where('created_at > ?', Date.today)
	end

	def self.on_date(d)
		@date = Date.parse(d)
		self.where(created_at: @date..(@date + 1.day))
	end

	def formatted_date
		self.date.formatted_date
	end

	def pretty_date
		self.date.pretty_date
	end

	def self.source_not_updated_today?(source)
		Date.parse(self.where(source:source).last.date.formatted_date) != Date.today
	end

	def self.count_todays_stories(source)
		self.where(source:source).from_today.count
	end

	def self.count_stories_on(source,day)
		self.where(source:source).on_date(day).count
	end

	def is_uniqish(source)
		stories = Story.all.from_today.where(:source=>source).order(:mixed).reject{|a| a.nil? || a.title.empty?}.to_a - [self]
		result = is_uniqish_enough?(stories,self)
	end

	def is_uniqish_by_tfidf(source,day)
		stories = Story.all.where(source:source).order(:mixed).on_date(day).reject{|a| a.nil? || a.title.empty?} - [self]
		result = is_uniqish_enough_by_tfidf?(stories,self)
	end

	def self.worst_since(date)
		self.where('created_at > ?', date)
        .select(:title,:source,:date,:mixed)
        .reject{|a| a.mixed.nan?}
        .sort{|a,b| a.mixed <=> b.mixed}
        .each{|a| a.source = a.source.titleize}
	end

	def update_source_typos
		self.source = self.source.downcase
		self.save!
	end



end
