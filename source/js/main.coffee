# # Register Service Worker
# window.onload = ->
#     'use strict'
#     if 'serviceWorker' of navigator
#         navigator.serviceWorker.register('./sw.js').then((registration) ->
#             console.log 'Service Worker Registered', registration
#             return
#         ).catch (err) ->
#             console.log 'Service Worker Failed to Register', err
#             return
#     return


onElementClick = (event) ->
	console.log "hello!"
	tokens = event.target.getAttribute("href").split("?")
	console.log tokens
	color = tokens[1]
	console.log color

url = window.location.href
numOfWindows = 100
arrayDiv = new Array
colors = document.getElementById('colors')
i = 0
while i < numOfWindows
	arrayDiv[i] = document.createElement('a')
	arrayDiv[i].id = 'block' + i
	arrayDiv[i].style.backgroundColor = randomColor = '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)
	arrayDiv[i].className = 'block' + i
	arrayDiv[i].className = 'color'
	arrayDiv[i].setAttribute 'href', "?" + randomColor
	# arrayDiv[i].setAttribute 'color', "" + randomColor
	arrayDiv[i].addEventListener("click", onElementClick) # to fix
	colors.appendChild arrayDiv[i]
	i++;

# Split URL
urlSeperator = "?"
if url.includes(urlSeperator)
	urlSplit = url.split(urlSeperator).pop()
	if urlSeperator < urlSplit
		value = urlSplit
		console.log("# Split URL:" + value)


actionUrl = (color) ->
	console.log("actionUrl: " + color)
	# Setup
	# inputName = inputName || 'animate' # CSS Selector: input[name="animate"]
	# urlParameterName = urlParameterName || 'action' # URL Parameter: www/?action=A&B&C
	# urlSeperator = urlParameterName + '='
	# parameterSeperator = '-'
	# inputSelector = 'input[name="' + inputName + '"]'
	# checkbox = document.querySelectorAll(inputSelector)
	# labelSelector = 'label'
	# label = document.querySelectorAll(labelSelector)


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

	# # Completely remove a Value from an Array
	# arrayRemoveAll = (array, value) ->
	# 	array.filter (val) ->
	# 		val != value

	# # Update URL Parameter
	# updateUrl = ->
	# 	setTimeout ->

	# 		# Check all Checkboxes and update 'values'-Array
	# 		# i = 0
	# 		# checkbox.forEach ->
	# 		# 	if (checkbox[i].checked)
	# 		# 		if !values.includes(checkbox[i].value)
	# 		# 			values.push(checkbox[i].value)
	# 		# 	else
	# 		# 		if values.includes(checkbox[i].value)
	# 		# 			values = arrayRemoveAll(values, checkbox[i].value)
	# 		# 	i++  

	# 		# Join and push the fresh Values
	# 		# urlParameter = values.join(parameterSeperator)
	# 		# urlSep = urlSeperator
	# 		# if !urlParameter
	# 		# 	urlParameter = '.' # Current Directory (invisible in URL)
	# 		r = r || 0
	# 		g = g || 0
	# 		b = b || 0
	# 		updatedUrlParameter = "?" + "r" + r + "g" + g + "b" + b
	# 		window.history.pushState(updatedUrlParameter, 'CACUPA', updatedUrlParameter)

# this.successClicker = () ->
#     if localStorage.hasOwnProperty('successToday')
#         if localStorage.successToday < getToday()
#             localStorage.successToday = getToday()
#             counterPlus()
#         else
#             console.log('You have allready succeeded today!')
#     else
#         populateStorage()
#     return

# populateStorage = () ->
#     localStorage.successToday = getToday()
#     localStorage.successCounter = 1

# counterPlus = () ->
#     if localStorage.successCounter > 0
#         localStorage.successCounter++
#     else
#         console.log('That should not have happened.')
#     return

# getToday = () ->
#     date = new Date()
#     year = date.getFullYear()
#     month = (if (date.getMonth() + 1 < 10) then '0' else '') + (date.getMonth() + 1)
#     day = (if (date.getDate() < 10) then '0' else '') + date.getDate()
#     todayInt = parseInt(year + month + day)
#     return todayInt