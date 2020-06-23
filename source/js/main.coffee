# Register Service Worker
window.onload = ->
    'use strict'
    if 'serviceWorker' of navigator
        navigator.serviceWorker.register('./sw.js').then((registration) ->
            console.log 'Service Worker Registered', registration
            return
        ).catch (err) ->
            console.log 'Service Worker Failed to Register', err
            return
    return

urlSeperator = '#'

debugLog = true
debugLog = (log) ->
    if debugLog
        console.log(log)

onPageLoad = () ->
    debugLog("onPageLoad()")
    setup()
    getUrlQuery(urlSeperator)

setup = () ->
    debugLog("setup()")
    createColorGrid()
    window.addEventListener 'popstate', (e) -> 
        debugLog('setup() -> popstate event')
        stateSwitch()

isFullScreen = () ->
    debugLog('isFullScreen()')
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenState = 'unknown'
    if fullScreenColor.style.height == '0px'
        debugLog('isFullScreen() -> fullScreenColor.style.height == "0px"')
        fullScreenState = false
    else
        debugLog('isFullScreen() -> else fullScreenColor.style.height = ' + fullScreenColor.style.height)
        fullScreenState = true

stateSwitch = () ->
    debugLog('stateSwitch()')
    if isFullScreen()
        debugLog('stateSwitch() -> if isFullScreen()')
        home()
    else
        debugLog('stateSwitch() -> else')
        getUrlQuery('#')

home = () ->
    debugLog('home()')
    disableFullScreenColor('/.')

windowHistoryPushState = (state3) ->
    debugLog('windowHistoryPushState("' + state3 + '")')
    window.history.pushState(state3, state3, state3)
    debugLog('windowHistoryPushState("' + state3 + '") -> window.history.state == ' + window.history.state)

enableFullScreenColor = (color) ->
    debugLog("enableFullScreenColor(" + color + ")")
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenColor.style.backgroundColor = color
    fullScreenColor.style.height = '100vh'
    document.getElementById('fullscreen').style.overflow = 'hidden'
    windowHistoryPushState(color)

disableFullScreenColor = (pushState) ->
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenColor.style.backgroundColor = null
    fullScreenColor.style.height = '0px'
    document.getElementById('fullscreen').style.overflow = null
    window.history.replaceState(null, null, window.location.pathname)

onElementClick = (event) ->
    debugLog('onElementClick(' + event + ')')
    tokens = event.target.getAttribute("href").split("#")
    color = "#" + tokens[1]
    enableFullScreenColor(color)

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
        enableFullScreenColor(colorCode)

createColorGrid = () ->
    debugLog('createColorGrid()')
    i = 1
    do topColorGrid = () ->
        debugLog('createColorGrid() -> selectedColors()')

    do autoColorGrid = () ->
        debugLog('createColorGrid() -> autoColors()')
        colorSquares = 1000
        divArray = new Array
        colors = document.getElementById('colors')
        while i < colorSquares
            divArray[i] = document.createElement('div')
            divArray[i].id = 'color' + i
            divArray[i].style.backgroundColor = randomColor = '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)
            divArray[i].className = 'color'
            divArray[i].setAttribute 'href', "" + randomColor
            divArray[i].addEventListener("click", onElementClick) # fixed by Lenny
            colors.appendChild divArray[i]
            i++;

onPageLoad()

# NOW
# back forward bug: mostly fixed...
# top color grid
# auto color grid

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

# pixel perfect squares (and elements)

# Browser-Sync Bug

# cert keys gitignore