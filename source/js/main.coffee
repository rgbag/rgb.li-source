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

userHistory = []
click = "" # to fix

debugLog = false
debugLog = (log) ->
    if debugLog == true
        console.log(log)

onPageLoad = () ->
    debugLog("onPageLoad()")
    setup()
    getColorCodeFromUrl()

setup = () ->
    debugLog("setup()")
    createColorGrid()
    window.addEventListener("scroll", onElementScroll)
    window.addEventListener 'popstate', (e) -> 
        debugLog('setup() -> popstate event')
        stateSwitch()

#endregion

##
#region state management

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
        debugLog('stateSwitch() -> if isFullScreen()')
        home()
    else
        debugLog('stateSwitch() -> else')
        getColorCodeFromUrl('#')

home = () ->
    debugLog('home()')
    disableFullScreenColor('/.')

pushWindowHistoryState = (state3) ->
    debugLog('pushWindowHistoryState("' + state3 + '")')
    if userHistory.length == 0 || click == true
        click = false
        userHistory.push(state3)
        window.history.pushState(state3, state3, state3)
    else
        debugLog("else " + userHistory)
    # debugLog('pushWindowHistoryState("' + state3 + '") -> window.history.state == ' + window.history.state)

onElementClick = (event) ->
    debugLog('onElementClick(' + event + ')')
    tokens = event.target.getAttribute("href").split("#")
    color = "#" + tokens[1]
    click = true
    enableFullScreenColor(color)

getColorCodeFromUrl = () ->
    debugLog("getColorCodeFromUrl('#')")
    url = window.location.href
    if url.includes('#')
        debugLog("getColorCodeFromUrl -> if url.includes('#')")
        query = '#' + url.split('#')[1]
        validateColorCode(query)

#endregion

##
#region color
randomColorCode = (colorType) ->
    debugLog('randomColorCode(colorType)')
    colorType = colorType || 'hex'
    if colorType == 'hex'
        '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)
        
createColorGridLegacy = () ->

createColorGrid = () ->
    debugLog('createColorGrid()')
    i = 0
    do topColorGrid = () ->
        debugLog('createColorGrid() -> selectedColors()')

    do autoColorGrid = () ->
        debugLog('createColorGrid() -> autoColors()')
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

onElementScroll = () ->
    debugLog('onElementScroll')
    # pixeltoBodyend = documentHeight - documentScrolledHeight
    body = document.body
    colorsDiv = document.getElementById('colors')
    pixelToBodyBottom = colorsDiv.offsetHeight - window.scrollY
    debugLog('documentHeight: ' + colorsDiv.offsetHeight)
    debugLog('window.scrollY: ' + window.scrollY)
    debugLog('window.innerHeight: ' + window.innerHeight)
    if pixelToBodyBottom < window.innerHeight * 2
        createColorGrid()

validateColorCode = (colorCode) ->
    debugLog('validateColorCode(' + colorCode + ')')
    if /^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode)
        debugLog('validateColorCode(' + colorCode + ') -> ' + colorCode + ' is a valid HEX color code')
        enableFullScreenColor(colorCode) # return true # 

enableFullScreenColor = (color) ->
    debugLog("enableFullScreenColor(" + color + ")")
    fullScreenColorDiv = '<div id="fullScreenColor" class="fadeIn" style="background-color: ' + color + ';"><div/>'
    document.getElementById('fullscreen').insertAdjacentHTML('afterbegin', fullScreenColorDiv)
    document.getElementById('fullscreen').style.overflow = 'hidden'
    pushWindowHistoryState(color)

disableFullScreenColor = (pushState) ->
    document.getElementById('fullScreenColor').remove()
    document.getElementById('fullscreen').style.overflow = null
    window.history.replaceState(null, null, window.location.pathname)

createColorPng = (width, height, colorCode) ->
    canvas = document.createElement("CANVAS")
    canvas.setAttribute("width", width)
    canvas.setAttribute("height", height)
    context = canvas.getContext("2d")
    context.fillStyle = colorCode
    context.fillRect(0, 0, width, height)
    image = canvas.toDataURL("image/png")
    image = canvas.toDataURL()
    return image

enableFullScreenColorPng = (color) ->
    debugLog("enableFullScreenColor(" + color + ", " + id + ")")
    png = createColorPng(360, 360, color)
    pngHTML = "<img id='colorImage' src='"+png+"' style='position:fixed; width:100vw; height:100vh; image-rendering: pixelated;'>"
    document.getElementById('fullscreen').insertAdjacentHTML('afterbegin', pngHTML)
    pushWindowHistoryState(color)
#endregion

## kickstart
onPageLoad()

##
#region notes

# NOW
# working home pwa with cache
# seperate code to files
# metatags
# png sharing bug 
# top colors noscript to coffee

# hide ios tab bar?

# 5x Touch Menu
# Bei Fullscreen wird immer zuerst unten eine Menüleiste angezeigt, notch,
# bei erneutem Klick auf die Farbe wird die Menüleiste ausgeblendet
# und kann nur über Browser Back zurückgeholt werden, oder 5x Touch...

# color pwa
# v1.5.0?

# cursor
# https://www.cssscript.com/interacitve-cursor-dot/

# Backwards compatible, future proof :)

# Browser-Sync Click Bug
# https://github.com/BrowserSync/browser-sync/issues/49

# Cursor
# https://www.cssscript.com/circle-cursor-pointer/

# cert & key gitignore + documentation

#endregion