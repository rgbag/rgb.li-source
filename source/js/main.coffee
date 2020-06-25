##
#region service worker

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

#endregion

##
#region setup

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
    document.getElementById('fullscreen').insertAdjacentHTML('afterbegin', '<div id="fullScreenColor"></div>')
    createColorGrid()
    window.addEventListener 'popstate', (e) -> 
        debugLog('setup() -> popstate event')
        stateSwitch()

#endregion

##
#region state management

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

#endregion

##
#region color
validateColorCode = (colorCode) ->
    debugLog('validateColorCode(' + colorCode + ')')
    if /^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode)
        debugLog('validateColorCode(' + colorCode + ') -> ' + colorCode + ' is a valid HEX color code')
        enableFullScreenColor(colorCode) # return true # 

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

createColorPNG = (width, height, colorCode ) ->
    canvas = document.createElement("CANVAS")
    canvas.setAttribute("width", width)
    canvas.setAttribute("height", height)
    context = canvas.getContext("2d")
    context.fillStyle = colorCode
    context.fillRect(0, 0, width, height)
    image = canvas.toDataURL("image/png")
    image = canvas.toDataURL()
    return image

enableFullScreenColor = (color) ->
    debugLog("enableFullScreenColor(" + color + ")")
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenColor.style.backgroundColor = color
    fullScreenColor.style.height = '100vh'
    fullScreenColor.style.display = 'none'
    png = createColorPNG(360, 360, color)
    pngHTML = "<img id='colorImage' src='"+png+"' style='position:fixed; width:100vw; height:100vh; image-rendering: pixelated;'>"
    document.getElementById('fullscreen').insertAdjacentHTML('afterbegin', pngHTML)
    document.getElementById('fullscreen').style.overflow = 'hidden'
    windowHistoryPushState(color)

disableFullScreenColor = (pushState) ->
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenColor.style.backgroundColor = null
    fullScreenColor.style.height = '0px'
    document.getElementById('colorImage').remove()
    document.getElementById('fullscreen').style.overflow = null
    window.history.replaceState(null, null, window.location.pathname)

#endregion

onPageLoad()

##
#region notes

# NOW
# state management / fullScreenColor
# animation
# top colors noscript to coffee
# lazy loading
# metatags
# working pwa

# 5x Touch Menu
# back forward bug: mostly fixed...
    # browser-sync second device back forward sync

# Backwards compatible, future proof :)

# Browser-Sync Click Bug
# https://github.com/BrowserSync/browser-sync/issues/49

# cert & key gitignore + documentation

#endregion