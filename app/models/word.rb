class Word < ActiveRecord::Base
	# accepts_nested_attributes_for :words, allow_destroy: true 
	has_and_belongs_to_many :users

	validates :pinnin,
		presence: true
	validates :rawpinnin,
		presence: true
	validates :styledpinnin,
		presence: true
	validates :kantaiji,
		presence: true
	validates :hinshi,
		inclusion:{
			in: ["noun","verb","adjective","adverb", "preposition","number","conjunction", "exclamation", "rigoushi","idiom","auxiliary_verb","uncategorized", "other"]
		}
	validates :page,
		numericality:{
			only_integer: true
		}
	validates :section,
		numericality:{
			only_integer: true
		}


end
