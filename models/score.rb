class Score < ActiveRecord::Base

	before_create :set_just_created

	scope :find_by_source, -> (paper) { where(:source => paper) }
	scope :express, -> { where(source:"express") }
	scope :guardian, -> { where(source:"guardian") }
	scope :independent, -> { where(source:"independent") }
	scope :mail, -> { where(source:"mail") }
	scope :telegraph, -> { where(source:"telegraph") }
	scope :times, -> { where(source:"times") }
	scope :mirror, -> { where(source:"mirror") }
	scope :ft, -> { where(source:"ft") }
	scope :on_date, -> (day) { where(date:day) } #day must be Date format, not string

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

	def self.main_five_sources
		self.where('source != ?','mirror').where('source != ?','ft')
	end

	def is_valid?
		!first.score.nil? && !first.score.nan?
	end

	def just_created?
    	@just_created || false
  	end

	private

  # Set a flag indicating this model is just created

	  def set_just_created
	    @just_created = true
	  end

end
