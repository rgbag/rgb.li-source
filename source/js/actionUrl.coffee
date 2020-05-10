# CSS Animation Checkbox URL Parameter Action CACUPA
actionUrl = (inputName, urlParameterName) ->

	# Setup
	inputName = inputName || 'animate' # CSS Selector: input[name="animate"]
	urlParameterName = urlParameterName || inputName || 'action' # URL Parameter: www/?action=A&B&C
	urlSeperator = '?' + urlParameterName + '='
	parameterSeperator = '&'
	inputSelector = 'input[name="' + inputName + '"]'
	checkbox = document.querySelectorAll(inputSelector)
	labelSelector = 'label'
	label = document.querySelectorAll(labelSelector)
	url = window.location.href

	# Split URL if
	if url.includes(urlSeperator)
		urlSplit = url.split(urlSeperator).pop()
		if urlSeperator < urlSplit
			values = urlSplit.split(parameterSeperator)
		else
			values = [] 
	else
		values = []

	# Activate Checkbox via URL Parameter
	i = 0
	checkbox.forEach ->
		if values.includes(checkbox[i].value)
			checkbox[i].checked = true
		i++

	# Add Event Listeners to all Labels 
	i = 0
	label.forEach -> 
		label[i].addEventListener("click", ->
			updateUrl()
		)
		i++

	# Completely remove a Value from an Array
	arrayRemoveAll = (array, value) ->
		array.filter (val) ->
			val != value

	# Update URL Parameter
	updateUrl = ->
		setTimeout ->
			# Check all Checkboxes and update 'values'-Array
			i = 0
			checkbox.forEach ->
				if (checkbox[i].checked)
					if !values.includes(checkbox[i].value)
						values.push(checkbox[i].value)
				else
					if values.includes(checkbox[i].value)
						values = arrayRemoveAll(values, checkbox[i].value)
				i++  
			# Join and push the fresh Values
			urlParameter = values.join(parameterSeperator)
			urlSep = urlSeperator
			if !urlParameter
				urlSep = '.' # Current Directory (invisible in URL)
			updatedUrlParameter = urlSep + urlParameter
			window.history.pushState(updatedUrlParameter, 'CACUPA', updatedUrlParameter)
		, 0  # Lucky Quickfix

# Call CACUPA
actionUrl('animate', 'party')