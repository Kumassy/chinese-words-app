json.array!(@words) do |word|
  json.extract! word, :id, :pinnin, :kantaiji, :hinshi, :imi, :rigoushi, :page, :section
  json.url word_url(word, format: :json)
end
