class Word < ActiveRecord::Base
	belongs_to :story
	validates :storyid, presence: true
	validates :lemma, presence: true, uniqueness: true


end
