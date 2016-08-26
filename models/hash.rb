class Hash
	def format_for_dropbox
		return [self['date'],
				self['Mail'],
				self['Times'],
				self['Express'],
				self['Telegraph'],
				self['Guardian'],
				self['Independent']]
	end

	def to_percentages
		hash = ActiveSupport::OrderedHash.new()
		self.each_pair do |k,v|
			next if v.nil? || v.nan?
			hash[k] = 100-(v/self['average']).round(2)*100
		end
		return hash.sort_by { |name, percent| percent }
	end

	def get_scoring_words
	self[:words].select{|k,v|v[:afinn]!=0 or v[:wiebe]!=0} 
	end
end