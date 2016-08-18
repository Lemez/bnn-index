class DailyScore < ActiveRecord::Base

#<DailyScore id: 7020, mail: 0.5, telegraph: -0.8, times: 1.0, average: -2.3, guardian: -6.6, independent: -1.1, express: -4.7, date: "2016-05-21 00:00:00", created_at: "2016-05-21 16:54:25", updated_at: "2016-05-21 16:54:25", dateformat: nil>

	def self.from_day(day)
		self.where('created_at > ?', day)
	end

	def self.from_today
		self.where('created_at > ?', Date.today)
	end

	def self.get_trophies_since(day)
		@trophies = ActiveSupport::OrderedHash.new
		CURRENT_NAMES.each{|f| @trophies[f]=0}
		fields = CURRENT_NAMES.map(&:to_sym)

		self.from_day(day).select(fields).each do |day|
          object = day.attributes # AR to hash
          sample = day.attributes.values[-1]
          next if sample.nil? || sample.nan?
          winner = object.key(object.values.compact.min) # compact: without nil, then min value
          @trophies[winner] += 1
          end 

        @trophies.sort_by{|paper,trophies|trophies}.reverse

	end
end
