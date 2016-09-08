init = ->
	# $('#view td.to').on 'click', ->
	# 	$('#view td.to p').toggle()
	# 	return
	# return

	$('#view td.to').each (i,elem) ->
		$(elem).on 'click', ->
			$(elem).find('div.to-wrapper').toggleClass('hidden')
			return
		return

	
onsenInit = ->
	$('#onsen .summary').each (i,elem) ->
		console.log "hoge"
		$(elem).on 'click', ->
			$(elem).find('div.summary-inner').toggleClass('summary-hidden')
			return
		return

$(document).on('page:change',init)
# setTimeout ->
# 	onsenInit()
# ,500