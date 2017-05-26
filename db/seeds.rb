# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'json'
data = IO.read('db/words.json')
JSON.parse(data).each do |row|
	Word.create(
		:id => row["id"],
		:pinnin => row["pinnin"],
		:kantaiji => row["kantaiji"],
		:hinshi => row["hinshi"],
		:imi => row["imi"],
		:page => row["page"],
		:section => row["section"],
		:created_at => row["created_at"],
		:updated_at => row["updated_at"],
		:styledpinnin => row["styledpinnin"],
		:rawpinnin => row["rawpinnin"]
	)
end
