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

numOfWindows = 100
arrayDiv = new Array
i = 0
while i < numOfWindows
  arrayDiv[i] = document.createElement('a')
  arrayDiv[i].id = 'block' + i
  arrayDiv[i].style.backgroundColor = randomColor = '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)
  arrayDiv[i].className = 'block' + i
  arrayDiv[i].className = 'color'
  arrayDiv[i].setAttribute 'href', "?hex" + randomColor
  document.getElementById('colors').appendChild arrayDiv[i]
  i++;


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