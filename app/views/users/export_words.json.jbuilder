json.array!(@words) do |word|
	json.extract! word, :id, :pinnin, :kantaiji,:hinshi,:imi,:page,:section,:created_at,:updated_at,:styledpinnin,:rawpinnin
end