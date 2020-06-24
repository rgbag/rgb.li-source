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
#region config
urlSeperator = '#'
nrColorSquares = 1000

############################################################
debugLog = true

#endregion

############################################################
debugLog = (log) ->
    if debugLog
        console.log(log)

############################################################
onPageLoad = () ->
    debugLog("onPageLoad()")
    setup()
    useColorCodeFromQueryURL()
    return

############################################################
#region setup
setup = () ->
    debugLog("setup()")
    createColorGrid()
    ## What is this supposed to do?
    window.addEventListener 'popstate', (e) -> 
        debugLog('setup() -> popstate event')
        adjustDisplayState()
    return

############################################################
#region createColorGrid
createColorGrid = () ->
    debugLog('createColorGrid()')
    
    divArray = []
    colors = document.getElementById('colors')

    for i in [0..nrColorSquares]
        color = generateRandomColorCode()
        square = createColorSquare(color)
        divArray[i] = square
        colors.appendChild square

    return

############################################################
createColorSquare = (color) ->
    el = document.createElement('div')
    el.style.backgroundColor = color
    el.className = "color"
    el.setAttribute 'href', "" + color
    el.addEventListener("click", onElementClick) # fixed by Lenny
    return el

############################################################
onElementClick = (event) ->
    debugLog('onElementClick(' + event + ')')
    url = event.target.getAttribute("href")
    return unless url.includes(urlSeperator)

    color = colorCodeFromURL(url)
    enablefullScreenColor(color)
    return

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
    return

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
    return

############################################################
windowHistoryPushState = (state3) ->
    debugLog('windowHistoryPushState("' + state3 + '")')
    window.history.pushState(state3, state3, state3)
    debugLog('windowHistoryPushState("' + state3 + '") -> window.history.pushState("' + state3 + '", "' + state3 + '", "' + state3 + '")')
    debugLog('windowHistoryPushState("' + state3 + '") -> window.history.state == ' + window.history.state)
    return

############################################################
enablefullScreenColor = (color) ->
    debugLog("enablefullScreenColor(" + color + ")")
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenColor.style.backgroundColor = color
    fullScreenColor.style.height = '100vh'
    windowHistoryPushState(color)
    return

############################################################
disablefullScreenColor = (pushState) ->
    fullScreenColor = document.getElementById('fullScreenColor')
    fullScreenColor.style.backgroundColor = null
    fullScreenColor.style.height = '0px'
    # windowHistoryPushState(pushState)
    return

#endregion

#endregion

############################################################
#region useColorCodeFromURL
useColorCodeFromQueryURL = () ->
    debugLog('useColorCodeFromQueryURL("' + urlSeperator + '")')

    urlSeperator = urlSeperator || "?"
    url = window.location.href
    return unless url.includes(urlSeperator)

    debugLog('useColorCodeFromQueryURL -> url.includes(' + urlSeperator + ')')
    code = colorCodeFromURL(url)
    useColorCode(code)
    
    return

useColorCode = (colorCode) ->
    debugLog('useColorCode(' + colorCode + ')')
    if isValidColorCode(colorCode)
        debugLog('useColorCode(' + colorCode + ') -> ' + colorCode + ' is a valid HEX color code')
        enablefullScreenColor(colorCode)
    return

#endregion

############################################################
#region utilFunctions
isValidColorCode = (colorCode) -> /^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode)

generateRandomColorCode = -> '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)

colorCodeFromURL = (url) ->  '#' + url.split(urlSeperator)[1]

#endregion

############################################################
# onPageLoad()


############################################################
# create the Image
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

png = createColorPNG(100, 100, "#61811a")
newTab = window.open()
newTab.document.body.innerHTML = "<img src='"+png+"'>"