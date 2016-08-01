class DailyScore < ActiveRecord::Base

#<DailyScore id: 7020, mail: 0.5, telegraph: -0.8, times: 1.0, average: -2.3, guardian: -6.6, independent: -1.1, express: -4.7, date: "2016-05-21 00:00:00", created_at: "2016-05-21 16:54:25", updated_at: "2016-05-21 16:54:25", dateformat: nil>

	def self.from_day(day)
		self.where('created_at > ?', day)
	end

	def self.from_today
		self.where('created_at > ?', Date.today)
	end
end
