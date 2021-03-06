// Generated by CoffeeScript 2.4.1
(function() {
  //#
  //region setup
  var click, createColorGrid, disableFullScreenColor, enableFullScreenColor, getColorCodeFromUrl, home, isFullScreen, kickstart, onElementClick, onScroll, pushWindowHistoryState, randomColorCode, setup, stateSwitch, userHistory, validateHexColorCode;

  setup = function() {
    //console.log('setup()')
    createColorGrid();
    window.addEventListener('scroll', onScroll);
    return window.addEventListener('popstate', function(e) {
      //console.log("window.addEventListener 'popstate'")
      return stateSwitch();
    });
  };

  kickstart = function() {
    //console.log('kickstart()')
    setup();
    return getColorCodeFromUrl();
  };

  //endregion

  //#
  //region state management
  userHistory = [];

  click = 0;

  isFullScreen = function() {
    var fullScreenState;
    //console.log('isFullScreen()')
    if (document.getElementById('fullScreenColor') === null) {
      return fullScreenState = false;
    } else {
      return fullScreenState = true;
    }
  };

  stateSwitch = function() {
    //console.log('stateSwitch()')
    // browser history state change by user
    if (isFullScreen()) {
      //console.log('if isFullScreen()')
      return home();
    } else {
      //console.log('if not isFullScreen()')
      return getColorCodeFromUrl('#');
    }
  };

  home = function() {
    //console.log('home()')
    return disableFullScreenColor('/.');
  };

  pushWindowHistoryState = function(state3) {
    //console.log('pushWindowHistoryState("' + state3 + '")')
    if (userHistory.length === 0 || click === 1) {
      //console.log('if userHistory.length == 0 || click == 1')
      click = 0;
      userHistory.push(state3);
      return window.history.pushState(state3, state3, state3);
    }
  };

  onElementClick = function(evt) {
    var color, tokens;
    //console.log('onElementClick()', evt)
    tokens = evt.target.getAttribute("href").split("#");
    color = "#" + tokens[1];
    click = 1;
    return enableFullScreenColor(color);
  };

  onScroll = function() {
    var colorsDiv, pixelToBottom;
    //console.log('onScroll()')
    colorsDiv = document.getElementById('colors');
    pixelToBottom = colorsDiv.offsetHeight - window.scrollY;
    if (pixelToBottom < window.innerHeight * 2) {
      return createColorGrid();
    }
  };

  getColorCodeFromUrl = function() {
    var query, url;
    //console.log("getColorCodeFromUrl('#')")
    url = window.location.href;
    if (url.includes('#')) {
      //console.log("if url.includes('#')")
      query = '#' + url.split('#')[1];
      return validateHexColorCode(query);
    }
  };

  //endregion

  //#
  //region color
  randomColorCode = function(colorType) {
    //console.log('randomColorCode(' + colorType + ')')
    colorType = colorType || 'hex';
    if (colorType === 'hex') {
      return '#' + (0x1000000 + (Math.random()) * 0xffffff).toString(16).substr(1, 6);
    }
  };

  createColorGrid = function() {
    var colorSquares, colors, divArray, i, randomColor, results;
    //console.log('createColorGrid()')
    i = 0;
    colorSquares = 200;
    divArray = new Array;
    colors = document.getElementById('colors');
    results = [];
    while (i < colorSquares) {
      divArray[i] = document.createElement('div');
      divArray[i].style.backgroundColor = randomColor = randomColorCode('hex');
      divArray[i].className = 'color';
      divArray[i].setAttribute('href', "" + randomColor);
      divArray[i].addEventListener("click", onElementClick);
      colors.appendChild(divArray[i]);
      results.push(i++);
    }
    return results;
  };

  validateHexColorCode = function(colorCode) {
    var url;
    //console.log('validateHexColorCode(' + colorCode + ')')
    if (/^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode)) {
      //console.log(colorCode + ' is a valid HEX color code.')
      return enableFullScreenColor(colorCode);
    } else {
      //console.log(colorCode + ' is not a valid HEX color code.')
      url = window.location.href;
      return window.history.replaceState(null, null, url.split('#')[0]);
    }
  };

  enableFullScreenColor = function(color) {
    var fullScreenColorDiv;
    //console.log('enableFullScreenColor(' + color + ')')
    fullScreenColorDiv = '<div id="fullScreenColor" class="fadeIn" style="background-color: ' + color + ';"><div/>';
    document.body.insertAdjacentHTML('afterbegin', fullScreenColorDiv);
    document.body.style.overflow = 'hidden';
    return pushWindowHistoryState(color);
  };

  disableFullScreenColor = function(pushState) {
    document.getElementById('fullScreenColor').remove();
    document.body.style.overflow = null;
    return window.history.replaceState(null, null, window.location.pathname);
  };

  //endregion

  //#
  //region functions for later

  // isValidColorCode = (colorCode) -> /^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode)
  // generateRandomColorCode = -> '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6)
  // colorCodeFromURL = (url) ->  '#' + url.split(urlSeperator)[1]

  // createColorPng = (width, height, colorCode) ->
  //     canvas = document.createElement("CANVAS")
  //     canvas.setAttribute("width", width)
  //     canvas.setAttribute("height", height)
  //     context = canvas.getContext("2d")
  //     context.fillStyle = colorCode
  //     context.fillRect(0, 0, width, height)
  //     image = canvas.toDataURL("image/png")
  //     image = canvas.toDataURL()
  //     return image

  // enableFullScreenColorPng = (color) ->
  //     png = createColorPng(360, 360, color)
  //     pngHTML = "<img id='colorImage' src='"+png+"' style='position:fixed; width:100vw; height:100vh; image-rendering: pixelated;'>"
  //     document.body.insertAdjacentHTML('afterbegin', pngHTML)
  //     pushWindowHistoryState(color)

  //endregion
  kickstart();

  //#
  // region service worker
  window.onload = function() {
    'use strict';
    if ('serviceWorker' in navigator) {
      //console.log 'Service Worker Registered', registration
      navigator.serviceWorker.register('./sw.js').then(function(registration) {}).catch(function(err) {});
    }
  };

  //endregion
  //console.log 'Service Worker Failed to Register', err

}).call(this);
