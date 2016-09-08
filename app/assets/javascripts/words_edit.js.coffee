class Data
	constructor: (index, _qq) ->
		_d = {
			"no" : "",
			"id" : null,               #データベースのidを入れとく, null=データベースにない新規エントリ	
			"action": "create",        #create|update|delete
			"action_old": "",          #deleteからの復帰用
			"document" : null,
			"isSync" : false,          #データは同期済み？
			"pinnin" : "",
			"styledpinnin" : "",
			"rawpinnin" : "",
			"kantaiji" : "",
			"hinshi" : "",
			"imi" : "",
			# "rigoushi":"" ,
			"page" : "",
			"section" : "",
		}
		_qm = _qq

		_d["document"] = $("#words_edit > table > tbody > tr#ajax-section-no-#{index}")
		_d["no"] = index
		if (_d["document"].attr 'data-id')?
			_d["id"] = _d["document"].attr 'data-id'
		if _d["id"] isnt null
			_d["isSync"] = true #nullじゃなかったら同期済みにしておく
			_d["action"] = "update"
		
		_d["rawpinnin"] = _d["document"].find(":text[name=\"rawpinnin\"]").val()
		_d["kantaiji"] = _d["document"].find(":text[name=\"kantaiji\"]").val()
		_d["hinshi"] = _d["document"].find(":text[name=\"hinshi\"]").val()
		_d["imi"] = _d["document"].find(":text[name=\"imi\"]").val()
		# _d["rigoushi"] = _d["document"].find(":checkbox[name=\"rigoushi\"]").prop('checked')
		_d["page"] = _d["document"].find(":text[name=\"page\"]").val()
		_d["section"] = _d["document"].find(":text[name=\"section\"]").val()




		@isDone = ->
			if _d["no"] isnt ""
				true
			else
				false
		@logging = ->
			console.log _d
			return
		@getParamsWithId = ->
			_d["rawpinnin"] = _d["document"].find(":text[name=\"rawpinnin\"]").val()
			_d["kantaiji"] = _d["document"].find(":text[name=\"kantaiji\"]").val()
			_d["hinshi"] = _d["document"].find(":text[name=\"hinshi\"]").val()
			_d["imi"] = _d["document"].find(":text[name=\"imi\"]").val()
			_d["page"] = _d["document"].find(":text[name=\"page\"]").val()
			_d["section"] = _d["document"].find(":text[name=\"section\"]").val()
			@stylePinnin()
			result = {
				"id"			: _d["id"],
				"action"		: _d["action"],
				"pinnin"		: _d["pinnin"],
				"styledpinnin" 	: _d["styledpinnin"],
				"rawpinnin" 	: _d["rawpinnin"],
				"kantaiji"		: _d["kantaiji"],
				"hinshi"		: _d["hinshi"],
				"imi"			: _d["imi"],
				# "rigoushi"	: _d["rigoushi"],
				"page"			: _d["page"],
				"section"		: _d["section"],
			}
		@setIsSync = (t)->
			_d["isSync"] = t
			_d["document"].attr {
				"isuptodate" : t
			}

			return
		@setId = (i) ->
			_d["id"] = i
		@setAction = (a) ->
			_d["action"] = a
		@setClass = (c) ->
			_d["document"].addClass c
		@stylePinnin = ->
			if _d["rawpinnin"]
			    _d["styledpinnin"] = _d["rawpinnin"].replace(/a1/g,"ā")
			    .replace(/a2/g,"á")
			    .replace(/a3/g,"ǎ")
			    .replace(/a4/g,"à")
			    .replace(/e1/g,"ē")
			    .replace(/e2/g,"é")
			    .replace(/e3/g,"ě")
			    .replace(/e4/g,"è")
			    .replace(/i1/g,"ī")
			    .replace(/i2/g,"í")
			    .replace(/i3/g,"ǐ")
			    .replace(/i4/g,"ì")
			    .replace(/o1/g,"ō")
			    .replace(/o2/g,"ó")
			    .replace(/o3/g,"ǒ")
			    .replace(/o4/g,"ò")
			    .replace(/u1/g,"ū")
			    .replace(/u2/g,"ú")
			    .replace(/u3/g,"ǔ")
			    .replace(/u4/g,"ù")
			    .replace(/v1/g,"ǖ")
			    .replace(/v2/g,"ǘ")
			    .replace(/v3/g,"ǚ")
			    .replace(/v4/g,"ǜ")
			    .replace(/v/g,"ü")

			    _d["pinnin"] = _d["rawpinnin"].replace(/a1/g,"a")
			    .replace(/a2/g,"a")
			    .replace(/a3/g,"a")
			    .replace(/a4/g,"a")
			    .replace(/e1/g,"e")
			    .replace(/e2/g,"e")
			    .replace(/e3/g,"e")
			    .replace(/e4/g,"e")
			    .replace(/i1/g,"i")
			    .replace(/i2/g,"i")
			    .replace(/i3/g,"i")
			    .replace(/i4/g,"i")
			    .replace(/o1/g,"o")
			    .replace(/o2/g,"o")
			    .replace(/o3/g,"o")
			    .replace(/o4/g,"o")
			    .replace(/u1/g,"u")
			    .replace(/u2/g,"u")
			    .replace(/u3/g,"u")
			    .replace(/u4/g,"u")
			    .replace(/v1/g,"u")
			    .replace(/v2/g,"u")
			    .replace(/v3/g,"u")
			    .replace(/v4/g,"u")
			    .replace(/v/g,"u")
		@reflectPinnin = ->
			_d["document"].find("span.styledpinnnin").text _d["styledpinnin"]
			return



		@stylePinnin()

		_d["document"].find(":text[name=\"rawpinnin\"]").change =>
			_d["rawpinnin"] = _d["document"].find(":text[name=\"rawpinnin\"]").val()
			@setIsSync false
			_qm.addJob(@)
			@stylePinnin()
			@reflectPinnin()
			return
		_d["document"].find(":text[name=\"rawpinnin\"]").keyup =>
			_d["rawpinnin"] = _d["document"].find(":text[name=\"rawpinnin\"]").val()
			@stylePinnin()
			@reflectPinnin()

			unless _d["rawpinnin"] is ""
				$.ajax
					type: "GET",
					method: "GET",
					url: "https://inputtools.google.com/request",
					data:
						"text"	: _d["pinnin"].toLowerCase(),
						"itc"	: "zh-t-i0-pinyin",
						"num"	: 10,
				.done (data, textStatus, jqXHR) ->
					p = JSON.parse data
					# console.log p[1][0][1]
					$("#pinnin-translation-list-#{ _d["no"] }").empty()

					if p[1][0][1]?
						$("#pinnin-translation-list-#{ _d["no"] }").append (
							for t in p[1][0][1]
								"<option value=\"#{t}\">"
						)
					return
				.fail (jqxhr, status, error) ->
					console.log "Pinnin translation Error! #{error}"
					return
				return
		_d["document"].find(":text[name=\"rawpinnin\"]").blur =>
			if _d["document"].find(":text[name=\"kantaiji\"]").val() is ""
				_kantaiji = $("#pinnin-translation-list-#{ _d["no"] } option").val()
				_d["document"].find(":text[name=\"kantaiji\"]").val _kantaiji
				_d["kantaiji"] = _kantaiji
			return
		_d["document"].find(":text[name=\"kantaiji\"]").change =>
			_d["kantaiji"] = _d["document"].find(":text[name=\"kantaiji\"]").val()
			@setIsSync false
			_qm.addJob(@)
			return
		_d["document"].find(":text[name=\"hinshi\"]").change =>
			_d["hinshi"] = _d["document"].find(":text[name=\"hinshi\"]").val()
			@setIsSync false
			_qm.addJob(@)
			return
		_d["document"].find(":text[name=\"hinshi\"]").focusout =>
			_d["hinshi"] = _d["document"].find(":text[name=\"hinshi\"]").val()
			@setIsSync false
			_qm.addJob(@)
			return
		_d["document"].find(":text[name=\"imi\"]").change =>
			_d["imi"] = _d["document"].find(":text[name=\"imi\"]").val()
			@setIsSync false
			_qm.addJob(@)
			return
		# _d["document"].find(":checkbox[name=\"rigoushi\"]").change =>
		# 	_d["rigoushi"] = _d["document"].find(":checkbox[name=\"rigoushi\"]").prop('checked')
		# 	@setIsSync false
		# 	_qm.addJob(@)
		# 	return
		_d["document"].find(":text[name=\"page\"]").change =>
			_d["page"] = _d["document"].find(":text[name=\"page\"]").val()
			@setIsSync false
			_qm.addJob(@)
			return
		_d["document"].find(":text[name=\"page\"]").bind 'keydown', 'down', =>
			_d["page"] = Number _d["document"].find(":text[name=\"page\"]").val()
			_d["page"] -= 1 
			_d["document"].find(":text[name=\"page\"]").val _d["page"]
			@setIsSync false
			_qm.addJob(@)
			return
		_d["document"].find(":text[name=\"page\"]").bind 'keydown', 'up', =>
			_d["page"] = Number _d["document"].find(":text[name=\"page\"]").val()
			_d["page"] += 1 
			_d["document"].find(":text[name=\"page\"]").val _d["page"]
			@setIsSync false
			_qm.addJob(@)
			return
		_d["document"].find(":text[name=\"section\"]").change =>
			_d["section"] = _d["document"].find(":text[name=\"section\"]").val()
			@setIsSync false
			_qm.addJob(@)
			return
		_d["document"].find(":text[name=\"section\"]").bind 'keydown', 'down', =>
			_d["section"] = Number _d["document"].find(":text[name=\"section\"]").val()
			_d["section"] -= 1 
			_d["document"].find(":text[name=\"section\"]").val _d["section"]
			@setIsSync false
			_qm.addJob(@)
			return
		_d["document"].find(":text[name=\"section\"]").bind 'keydown', 'up', =>
			_d["section"] = Number _d["document"].find(":text[name=\"section\"]").val()
			_d["section"] += 1 
			_d["document"].find(":text[name=\"section\"]").val _d["section"]
			@setIsSync false
			_qm.addJob(@)
			return
		_d["document"].find("img.delete").on 'click', =>
			# alert "delete! #{_d["id"]}"

			
			if ( _d["action"] is "create" or "update" )and _d["action"] isnt "delete"
				# @logging()
				_d["document"].addClass 'deleting'
				_d["action_old"] = _d["action"]

				_d["action"] = "delete"
				_qm.addJob(@)

				# 値を変更できないようにする
				_d["document"].find(":text[name=\"rawpinnin\"]").attr("disabled", "disabled")
				_d["document"].find(":text[name=\"kantaiji\"]").attr("disabled", "disabled")
				_d["document"].find(":text[name=\"hinshi\"]").attr("disabled", "disabled")
				_d["document"].find(":text[name=\"imi\"]").attr("disabled", "disabled")
				# _d["document"].find(":checkbox[name=\"rigoushi\"]").attr("disabled", "disabled")
				_d["document"].find(":text[name=\"page\"]").attr("disabled", "disabled")
				_d["document"].find(":text[name=\"section\"]").attr("disabled", "disabled")

				# console.log '->delete'
				# @logging()
			else if _d["action"] is "delete"
				_d["document"].removeClass 'deleting'
				_d["action"] = _d["action_old"]				# actionを復帰

				# TODO: updateすべきものをdeleteしてキャンセルしたときなどにjobリストがおかしくなる可能性？？？

				_d["document"].find(":text[name=\"rawpinnin\"]").removeAttr("disabled");
				_d["document"].find(":text[name=\"kantaiji\"]").removeAttr("disabled");
				_d["document"].find(":text[name=\"hinshi\"]").removeAttr("disabled");
				_d["document"].find(":text[name=\"imi\"]").removeAttr("disabled");
				# _d["document"].find(":checkbox[name=\"rigoushi\"]").removeAttr("disabled");
				_d["document"].find(":text[name=\"page\"]").removeAttr("disabled");
				_d["document"].find(":text[name=\"section\"]").removeAttr("disabled");

				# console.log 'delete->#########'
				# @logging()
			return


		console.log _d


class DataManager
	_datalist = []

	constructor: ()->
		#
	addData: (index, _qq) ->
		_datalist[index] = new Data(index, _qq)
		return
	log: ->
		for key,value of _datalist 
			value.logging()
		return
	getDataAt: (index) ->
		_datalist[index]

class QueueManager
	_queues = []

	constructor: ()->
		_queues = []
	addJob: (_data) ->
		if (_queues.indexOf _data) is -1
			#要素が待ち行列に入ってないときのみ追加
			_queues.push _data
		# console.log "NowJob|||"
		# console.log _queues
		# console.log "|||"
		return
	doJob: ->
		for myData in _queues
			p = myData.getParamsWithId()

			# if p["id"] is null
			if p["action"] is "create"
				# create
				$.ajax
					type: "POST",
					url: "../../../../ajax/words",
					data:
						"word" : {
							"pinnin"	: p["pinnin"],
							"styledpinnin" : p["styledpinnin"],
							"rawpinnin" : p["rawpinnin"],
							"kantaiji"	: p["kantaiji"],
							"hinshi"	: p["hinshi"],
							"imi"		: p["imi"],
							# "rigoushi"	: p["rigoushi"],
							"page"		: p["page"],
							"section"	: p["section"],
						},
					context: myData,
				.done (data, textStatus, jqXHR) ->
					# console.log data
					# alert "Saved:" + data.id
					@setIsSync true
					@setId data.id
					@setAction "update"

					# https://gist.github.com/dakatsuka/1249674
					# 要素を待ち行列から削除
					_queues.splice (_queues.indexOf @ , 1)

					return
				.fail (jqxhr, status, error) ->
					alert "Error! #{error}"
					return
				# TODO: .failの追加

			# else if p["id"] isnt null
			else if p["action"] is "update"
				# update
				$.ajax
					type: "PUT",
					# method: "PATCH",
					url: "../../../../ajax/words",
					data:
						"word" : {
							"id"		: p["id"],
							"pinnin"	: p["pinnin"],
							"styledpinnin" : p["styledpinnin"],
							"rawpinnin" : p["rawpinnin"],
							"kantaiji"	: p["kantaiji"],
							"hinshi"	: p["hinshi"],
							"imi"		: p["imi"],
							# "rigoushi"	: p["rigoushi"],
							"page"		: p["page"],
							"section"	: p["section"],
						},
					context: myData,
				.done (data, textStatus, jqXHR) ->
					# alert "Update!!"
					# console.log data
					@setIsSync true

					# https://gist.github.com/dakatsuka/1249674
					# 要素を待ち行列から削除
					_queues.splice (_queues.indexOf @ , 1)

					return
				.fail (jqxhr, status, error) ->
					alert "Error! #{error}"
					return
			else if p["action"] is "delete"
				# delete
				$.ajax
					type: "DELETE",
					# method: "DELETE",
					url: "../../../../ajax/words",
					data:
						"word" : {
							"id"		: p["id"],
						},
					context: myData,
				.done (data, textStatus, jqXHR) ->
					# alert "Delete!!"
					@setIsSync true
					@setClass 'deleted'

					# https://gist.github.com/dakatsuka/1249674
					# 要素を待ち行列から削除
					_queues.splice (_queues.indexOf @ , 1)

					return
				.fail (jqxhr, status, error) ->
					alert "Error! #{error}"
					return
		return
	loggingAll : ->
		for q in _queues
			q.logging()


addRow = ->
	index = $('#words_edit > table > tbody > tr').length
	index +=1


	# retrive page and section from previos entry
	page = -1
	section = -1
	if index >=2
		page = $("#ajax-section-no-#{index-1} :text[name=\"page\"] ").val()
		section = $("#ajax-section-no-#{index-1} :text[name=\"section\"] ").val()

	$('#words_edit > table > tbody').append (
		"""
		<tr class="ajax-section" id="ajax-section-no-#{index}">
		    <td class="mdl-data-table__cell--non-numeric"><input class="mdl-textfield__input" type="text" name="rawpinnin"></td>
		    <td class="mdl-data-table__cell--non-numeric"><span class="styledpinnnin"></span></td>
	        <td class="mdl-data-table__cell--non-numeric"><input class="mdl-textfield__input" type="text" name="imi"></td>
	        <td class="mdl-data-table__cell--non-numeric"><input class="mdl-textfield__input" type="text" name="kantaiji" autocomplete="on" list="pinnin-translation-list-#{index}" ></td>
	        <td class="mdl-data-table__cell--non-numeric"><input class="mdl-textfield__input" type="text" name="hinshi" autocomplete="on" list="hinshi-list" value="uncategorized"></td>
	        <td><input class="mdl-textfield__input" type="text" name="page" value="#{page}"></td>
	        <td><input class="mdl-textfield__input" type="text" name="section" value="#{section}"></td>
	        <td><span class="isuptodatesign"></span></td>
	        <td><img class="delete" src="../../../../assets/button.png"></img></td>
	    </tr>
		"""
	)
	$('#autocomplete-lists').append (
		"""
		<datalist id="pinnin-translation-list-#{index}">
		</datalist>
		"""
	)

	$("#ajax-section-no-#{index} :text[name=\"rawpinnin\"] ").focus()

	dm.addData(index, qm)
	# dm.log()

	# re-register shortcut key
	$("input:text").bind('keydown', 'Ctrl+return', doSubmit)
	$("input:text").bind('keydown', 'Ctrl+d', addRow)
	return
doSubmit =  ->
	qm.doJob()
	return


qm = new QueueManager
dm = new DataManager


init = ->
	

	# addData if exists
	count = $('#words_edit > table > tbody > tr').length
	for i in [1..count]
		dm.addData(i, qm)

	$('#ajax-button').on 'click', ->
		addRow(dm,qm)
		return
	$('#ajax-submit').on 'click', ->
		doSubmit()
		return

	# register shortcuts
	$(document).bind('keydown', 'Ctrl+return', doSubmit)
	$(document).bind('keydown', 'Shift+return', doSubmit)
	$(document).bind('keydown', 'Alt+return', doSubmit)
	$(document).bind('keydown', 'Ctrl+d', addRow)
	$(document).bind('keydown', 'Alt+d', addRow)
	$(document).bind('keydown', 'Ctrl+q', addRow)
	$(document).bind('keydown', 'Alt+q', addRow)

	$("#ajax-button").bind('keydown', 'Ctrl+return', doSubmit)
	$("#ajax-button").bind('keydown', 'Shift+return', doSubmit)
	$("#ajax-button").bind('keydown', 'Alt+return', doSubmit)
	$("#ajax-submit").bind('keydown', 'Ctrl+d', addRow)
	$("#ajax-submit").bind('keydown', 'Alt+d', addRow)
	$("#ajax-submit").bind('keydown', 'Ctrl+q', addRow)
	$("#ajax-submit").bind('keydown', 'Alt+q', addRow)

	$("input:text").bind('keydown', 'Ctrl+return', doSubmit)
	$("input:text").bind('keydown', 'Shift+return', doSubmit)
	$("input:text").bind('keydown', 'Alt+return', doSubmit)
	$("input:text").bind('keydown', 'Ctrl+d', addRow)
	$("input:text").bind('keydown', 'Alt+d', addRow)
	$("input:text").bind('keydown', 'Ctrl+q', addRow)
	$("input:text").bind('keydown', 'Alt+q', addRow)


# TODO: Turbolink非対応時は呼ばれないかも....
# $(document).ready(init)
$(document).on('page:change',init)