module ApplicationHelper
	def get_styled_hinshi(h)
		case h
		when 'noun'
			'名詞'
		when 'verb'
			'動詞'
		when 'adjective'
			'形容詞'
		when 'adverb'
			'副詞'
		when 'preposition'
			'前置詞'
		when 'number'
			'数詞'
		when 'conjunction'
			'接続詞'
		when 'exclamation'
			'間投詞'
		when 'rigoushi'
			'離合詞'
		when 'idiom'
			'熟語'
		when 'other'
			'その他'
		when 'uncategorized'
			'未分類'
		when 'auxiliary_verb'
			'助動詞'
		else
			''
		end
	end
end