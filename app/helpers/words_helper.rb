module WordsHelper
	# def get_styled_hinshi(h)
	# 	case h
	# 	when 'noun'
	# 		'名詞'
	# 	when 'verb'
	# 		'動詞'
	# 	when 'rigoushi'
	# 		'離合詞'
	# 	end
	# end

	def get_styled_page(p)
		if p
			p.to_s+'ページ'
		end
	end

	def get_styled_section(s)
		if s
			s.to_s+'章'
		end
	end

	def get_view_header(s)
		case s
		when 'pinnin'
			'ピンイン'
		when 'kantaiji'
			'簡体字'
		when 'imi'
			'意味'
		when 'all'
			'全部'
		end
	end
end
