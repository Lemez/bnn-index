class DailyScore < ActiveRecord::Base

	serialize :topics, Array
	scope :since_day, -> (day) { where('date > ?', day) }

#<DailyScore id: 7020, mail: 0.5, telegraph: -0.8, times: 1.0, average: -2.3, guardian: -6.6, independent: -1.1, express: -4.7, date: "2016-05-21 00:00:00", created_at: "2016-05-21 16:54:25", updated_at: "2016-05-21 16:54:25", dateformat: nil>

	def self.from_today
		self.where(date:Date.today)
	end

	def self.get_trophies_since(day)
		@trophies = ActiveSupport::OrderedHash.new
		CURRENT_NAMES.each{|f| @trophies[f]=0}
		fields = CURRENT_NAMES.map(&:to_sym)

		self.since_day(day).select(fields).each do |day|
          object = day.attributes # AR to hash
          sample = day.attributes.values[-1]
          next if sample.nil? || sample.nan?

          winner = object.key(object.values.compact.min) # compact: without nil, then min value
          @trophies[winner] += 1
          end 

        @trophies.sort_by{|paper,trophies|trophies}.reverse

	end

	def self.get_scores_since(day)
		@totalDailyScores = {}

		CURRENT_NAMES.each{|f| @totalDailyScores[f]=0}
		@totalDailyScores['average']=0
		@totalDailyScores['size']=self.since_day(day).count

		self.since_day(day).select(CURRENT_NAMES.map(&:to_sym),:average).each do |d|

	          d.attributes.each_pair do |key,value|
	          	unless value.nil? || value.nan?
	          		@totalDailyScores[key] += value
	          	end
	          end
        end 

        @totalDailyScores.each_with_object({}) { |(key, value), hash| hash[key] = value.round(1) }

	end
end
