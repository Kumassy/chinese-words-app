# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


init = ->
	$("#words-printable :text[name=\"color-pinnin\"]").change =>
		val = $("#words-printable :text[name=\"color-pinnin\"]").val()
		$("#words-printable .printable-pinnin").css('color', val)
		return
	$("#words-printable :text[name=\"color-kantaiji\"]").change =>
		val = $("#words-printable :text[name=\"color-kantaiji\"]").val()
		$("#words-printable .printable-kantaiji").css('color', val)
		return
	$("#words-printable :text[name=\"color-imi\"]").change =>
		val = $("#words-printable :text[name=\"color-imi\"]").val()
		$("#words-printable .printable-imi").css('color', val)
		return

	$("#words-printable :text[name=\"font-pinnin\"]").change =>
		val = $("#words-printable :text[name=\"font-pinnin\"]").val()
		$("#words-printable .printable-pinnin").css('font-size',val+'px')
		return
	$("#words-printable :text[name=\"font-kantaiji\"]").change =>
		val = $("#words-printable :text[name=\"font-kantaiji\"]").val()
		$("#words-printable .printable-kantaiji").css('font-size',val+'px')
		return
	$("#words-printable :text[name=\"font-imi\"]").change =>
		val = $("#words-printable :text[name=\"font-imi\"]").val()
		$("#words-printable .printable-imi").css('font-size',val+'px')
		return

	$("#words-printable :checkbox[name=\"toggle-hinshi\"]").on 'change' ,->
		$("#words-printable .printable-hinshi").toggleClass 'printable-hidden'
		console.log 'sffs'
		return
	$("#words-printable :checkbox[name=\"toggle-page\"]").on 'change' ,->
		$("#words-printable .printable-page").toggleClass 'printable-hidden'
		console.log 'sffs'
		return
	$("#words-printable :checkbox[name=\"toggle-section\"]").on 'change' ,->
		$("#words-printable .printable-section").toggleClass 'printable-hidden'
		console.log 'sffs'
		return


$(document).on('page:change',init)