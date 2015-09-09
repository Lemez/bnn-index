class Story < ActiveRecord::Base

	scope :express, -> { where(source:"Express") }
	scope :guardian, -> { where(source:"Guardian") }
	scope :independent, -> { where(source:"Independent") }
	scope :mail, -> { where(source:"Mail") }
	scope :telegraph, -> { where(source:"Telegraph") }
	scope :times, -> { where(source:"Times") }

end
