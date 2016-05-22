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
end