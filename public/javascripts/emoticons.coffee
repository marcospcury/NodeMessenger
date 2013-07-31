define ['jquery', 'emoticonsDictionary'], ($, dictSmile) ->
	class Emoticons
		renderGrid: (containerElement) ->
			htmlIcons = []
			htmlIcons.push "<table class=\"emoticons\"><tr>"
			contaEmoticons = 0
			for item in dictSmile
				if contaEmoticons % 12 is 0
					htmlIcons.push "</tr><tr>"

				htmlIcons.push "<td class=\"click-emoticon\" param=\"#{contaEmoticons}\" title=\"#{item.text}\">#{item.image}</td>"
				contaEmoticons++

			htmlIcons.push "</table>"
			containerElement.html htmlIcons.join ''
			false
	Emoticons