# CSS Animation Checkbox URL Parameter Action CACUPA
actionUrl = (r,g,b) ->
	console.log("actionUrl")
	# Setup
	# inputName = inputName || 'animate' # CSS Selector: input[name="animate"]
	# urlParameterName = urlParameterName || 'action' # URL Parameter: www/?action=A&B&C
	# urlSeperator = urlParameterName + '='
	# parameterSeperator = '-'
	# inputSelector = 'input[name="' + inputName + '"]'
	# checkbox = document.querySelectorAll(inputSelector)
	# labelSelector = 'label'
	# label = document.querySelectorAll(labelSelector)
	url = window.location.href

	# Split URL
	urlSeperator = "?"
	if url.includes(urlSeperator)
		urlSplit = url.split(urlSeperator).pop()
		if urlSeperator < urlSplit
			value = urlSplit
			console.log(value)

	# Background Colro

	# values = [r,g,b]
	# Activate Checkbox via URL Parameter
	# i = 0
	# checkbox.forEach ->
	# 	if values.includes(checkbox[i].value)
	# 		checkbox[i].checked = true
	# 	i++

	# Add Event Listeners to all Labels 
	# i = 0
	# label.forEach -> 
	# 	arrayDiv[i].addEventListener("click", ->
	# 		updateUrl()
	# 	)
	# 	i++

	# Completely remove a Value from an Array
	arrayRemoveAll = (array, value) ->
		array.filter (val) ->
			val != value

	# Update URL Parameter
	updateUrl = ->
		setTimeout ->

			# Check all Checkboxes and update 'values'-Array
			# i = 0
			# checkbox.forEach ->
			# 	if (checkbox[i].checked)
			# 		if !values.includes(checkbox[i].value)
			# 			values.push(checkbox[i].value)
			# 	else
			# 		if values.includes(checkbox[i].value)
			# 			values = arrayRemoveAll(values, checkbox[i].value)
			# 	i++  

			# Join and push the fresh Values
			# urlParameter = values.join(parameterSeperator)
			# urlSep = urlSeperator
			# if !urlParameter
			# 	urlParameter = '.' # Current Directory (invisible in URL)
			r = r || 0
			g = g || 0
			b = b || 0
			updatedUrlParameter = "?" + "r" + r + "g" + g + "b" + b
			window.history.pushState(updatedUrlParameter, 'CACUPA', updatedUrlParameter)
		, 0  # Lucky Quickfix
	
	# updateUrl()

# Call CACUPA
# actionUrl(47,47,47)

# Check URL über Service Worker, bis dahin "?" 
# Oder dynamisch mit if Service Worker is true...
# rgb.li/rgb(2,1,3)