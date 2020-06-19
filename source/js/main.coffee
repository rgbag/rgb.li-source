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

############################################################
urlSeperator = '#'

############################################################
debugLog = true
debugLog = (log) ->
    if debugLog
        console.log(log)


############################################################
onPageLoad = () ->
    debugLog("onPageLoad()")
    setup()
    getUrlQuery(urlSeperator)

############################################################
#region setup
setup = () ->
    debugLog("setup()")
    createColorGrid()
    ## What is this supposed to do?
    window.addEventListener 'popstate', (e) -> 
        debugLog('setup() -> popstate event')
        adjustDisplayState()

############################################################
#region createColorGrid
createColorGrid = () ->
    debugLog('createColorGrid()')
    colorSquares = 1000
    divArray = new Array
    colors = document.getElementById('colors')
    i = 0
    while i < colorSquares
        divArray[i] = document.createElement('div')
        divArray[i].id = 'block' + i
        divArray[i].style.backgroundColor = randomColor = '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)
        divArray[i].className = 'block' + i
        divArray[i].className = 'color'
        divArray[i].setAttribute 'href', "" + randomColor
        divArray[i].addEventListener("click", onElementClick) # fixed by Lenny
        colors.appendChild divArray[i]
        i++;

#endregion


############################################################
#region displayStateFunctions
adjustDisplayState = () ->
    debugLog('adjustDisplayState()')
    if isFullScreen()
        debugLog('adjustDisplayState() -> if isFullScreen(): ' + isFullScreen())
        home()
    else
        fullScreenColor = document.getElementById('fullScreenColor')
        fullScreenColor.style.height = '100vh'

############################################################
isFullScreen = () ->
    debugLog('isFullScreen()')
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenState = 'unknown'
    if fullScreenColor.style.height = '0px' #bug? this is always true^^..
        debugLog('isFullScreen() -> fullScreenColor.style.height = "0px"')
        fullScreenState = true
    else
        debugLog('isFullScreen() -> fullScreenColor.style.height = ' + fullScreenColor.style.height)
        fullScreenState = false
    return fullScreenState

############################################################
home = () ->
    debugLog('home()')
    disablefullScreenColor('/.')

############################################################
windowHistoryPushState = (state3) ->
    debugLog('windowHistoryPushState("' + state3 + '")')
    window.history.pushState(state3, state3, state3)
    debugLog('windowHistoryPushState("' + state3 + '") -> window.history.pushState("' + state3 + '", "' + state3 + '", "' + state3 + '")')
    debugLog('windowHistoryPushState("' + state3 + '") -> window.history.state == ' + window.history.state)

############################################################
enablefullScreenColor = (color) ->
    debugLog("enablefullScreenColor(" + color + ")")
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenColor.style.backgroundColor = color
    fullScreenColor.style.height = '100vh'
    windowHistoryPushState(color)

############################################################
disablefullScreenColor = (pushState) ->
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenColor.style.backgroundColor = null
    fullScreenColor.style.height = '0px'
    # windowHistoryPushState(pushState)

#endregion

#endregion

onElementClick = (event) ->
    debugLog('onElementClick(' + event + ')')
    tokens = event.target.getAttribute("href").split("#")
    color = "#" + tokens[1]
    enablefullScreenColor(color)

getUrlQuery = (urlSeperator) ->
    debugLog('getUrlQuery("' + urlSeperator + '")')
    urlSeperator = urlSeperator || "?"
    url = window.location.href
    if url.includes(urlSeperator)
        debugLog('getUrlQuery -> if url.includes(' + urlSeperator + ')')
        query = '#' + url.split(urlSeperator)[1]
        validateColorCode(query)

validateColorCode = (colorCode) ->
    debugLog('validateColorCode(' + colorCode + ')')
    if /^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode)
        debugLog('validateColorCode(' + colorCode + ') -> ' + colorCode + ' is a valid HEX color code')
        enablefullScreenColor(colorCode)


onPageLoad()

# FUNCTIONS

# Config

# Generate Color Grid
    # Animate

# Set URL onClick

# Get Color from URL

# Open Color Screen with Menu

# Open Fullscreen Color

# Menu
    # Change Color

# Save Color to Favorites

# State Management
    # window.history
    # state variable

# Die ersten Farben manuell festlegen!

# Backwards compatible, future proof :)


