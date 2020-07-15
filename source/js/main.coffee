##
#region setup

debugLog = () ->
    if window.location.hostname == 'localhost'
        console.log(arguments...)

setup = () ->
    debugLog('setup()')
    createColorGrid()
    window.addEventListener('scroll', onScroll)
    window.addEventListener 'popstate', (e) -> 
        debugLog("window.addEventListener 'popstate'")
        stateSwitch()

kickstart = () ->
    debugLog('kickstart()')
    setup()
    getColorCodeFromUrl()

#endregion

##
#region state management

userHistory = []
click = 0

isFullScreen = () ->
    debugLog('isFullScreen()')
    if document.getElementById('fullScreenColor') == null
        fullScreenState = false
    else 
        fullScreenState = true

stateSwitch = () ->
    debugLog('stateSwitch()')
    # browser history state change by user
    if isFullScreen()
        debugLog('if isFullScreen()')
        home()
    else
        debugLog('if not isFullScreen()')
        getColorCodeFromUrl('#')

home = () ->
    debugLog('home()')
    disableFullScreenColor('/.')

pushWindowHistoryState = (state3) ->
    debugLog('pushWindowHistoryState("' + state3 + '")')
    if userHistory.length == 0 || click == 1
        debugLog('if userHistory.length == 0 || click == 1')
        click = 0
        userHistory.push(state3)
        window.history.pushState(state3, state3, state3)

onElementClick = (e) ->
    tokens = e.target.getAttribute("href").split("#")
    debugLog('onElementClick()', e)
    color = "#" + tokens[1]
    click = 1
    enableFullScreenColor(color)

onScroll = () ->
    debugLog('onScroll()')
    colorsDiv = document.getElementById('colors')
    pixelToBottom = colorsDiv.offsetHeight - window.scrollY
    if pixelToBottom < window.innerHeight * 2
        createColorGrid()

getColorCodeFromUrl = () ->
    debugLog("getColorCodeFromUrl('#')")
    url = window.location.href
    if url.includes('#')
        debugLog("if url.includes('#')")
        query = '#' + url.split('#')[1]
        validateHexColorCode(query)

#endregion

##
#region color

randomColorCode = (colorType) ->
    debugLog('randomColorCode(' + colorType + ')')
    colorType = colorType || 'hex'
    if colorType == 'hex'
        '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)
        
createColorGrid = () ->
    debugLog('createColorGrid()')
    i = 0
    colorSquares = 200
    divArray = new Array
    colors = document.getElementById('colors')
    while i < colorSquares
        divArray[i] = document.createElement('div')
        divArray[i].style.backgroundColor = randomColor = randomColorCode('hex')
        divArray[i].className = 'color'
        divArray[i].setAttribute 'href', "" + randomColor
        divArray[i].addEventListener("click", onElementClick)
        colors.appendChild divArray[i]
        i++;

validateHexColorCode = (colorCode) ->
    debugLog('validateHexColorCode(' + colorCode + ')')
    if /^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode)
        debugLog(colorCode + ' is a valid HEX color code.')
        enableFullScreenColor(colorCode)
    else
        debugLog(colorCode + ' is not a valid HEX color code.')
        url = window.location.href
        window.history.replaceState(null, null, url.split('#')[0])

enableFullScreenColor = (color) ->
    debugLog('enableFullScreenColor(' + color + ')')
    fullScreenColorDiv = '<div id="fullScreenColor" class="fadeIn" style="background-color: ' + color + ';"><div/>'
    document.body.insertAdjacentHTML('afterbegin', fullScreenColorDiv)
    document.body.style.overflow = 'hidden'
    pushWindowHistoryState(color)

disableFullScreenColor = (pushState) ->
    document.getElementById('fullScreenColor').remove()
    document.body.style.overflow = null
    window.history.replaceState(null, null, window.location.pathname)

#endregion

##
#region functions for later

# isValidColorCode = (colorCode) -> /^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode)
# generateRandomColorCode = -> '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)
# colorCodeFromURL = (url) ->  '#' + url.split(urlSeperator)[1]

# createColorPng = (width, height, colorCode) ->
#     canvas = document.createElement("CANVAS")
#     canvas.setAttribute("width", width)
#     canvas.setAttribute("height", height)
#     context = canvas.getContext("2d")
#     context.fillStyle = colorCode
#     context.fillRect(0, 0, width, height)
#     image = canvas.toDataURL("image/png")
#     image = canvas.toDataURL()
#     return image

# enableFullScreenColorPng = (color) ->
#     png = createColorPng(360, 360, color)
#     pngHTML = "<img id='colorImage' src='"+png+"' style='position:fixed; width:100vw; height:100vh; image-rendering: pixelated;'>"
#     document.body.insertAdjacentHTML('afterbegin', pngHTML)
#     pushWindowHistoryState(color)

#endregion

kickstart()

##
# region service worker

window.onload = ->
    'use strict'
    if window.location.hostname != 'localhost' # because of browser-sync error
        if 'serviceWorker' of navigator
            navigator.serviceWorker.register('./sw.js').then((registration) ->
                debugLog 'Service Worker Registered', registration
                return
            ).catch (err) ->
                debugLog 'Service Worker Failed to Register', err
                return
        return

#endregion

