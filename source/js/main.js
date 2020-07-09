// Generated by CoffeeScript 2.4.1
(function() {
  //#
  //region setup
  var click, colorCodeFromURL, createColorGrid, createColorPng, debugLog, disableFullScreenColor, enableFullScreenColor, enableFullScreenColorPng, generateRandomColorCode, getColorCodeFromUrl, home, isFullScreen, isValidColorCode, kickstart, onElementClick, onScroll, pushWindowHistoryState, randomColorCode, setup, stateSwitch, userHistory, validateHexColorCode;

  setup = function() {
    //debugLog('setup()')
    createColorGrid();
    window.addEventListener('scroll', onScroll);
    return window.addEventListener('popstate', function(e) {
      
      //debugLog("window.addEventListener 'popstate'")
      return stateSwitch();
    });
  };

  debugLog = function(log) {
    if (window.location.hostname === 'localhost') {
      return console.log(log);
    }
  };

  kickstart = function() {
    //debugLog('kickstart()')
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
    //debugLog('isFullScreen()')
    if (document.getElementById('fullScreenColor') === null) {
      return fullScreenState = false;
    } else {
      return fullScreenState = true;
    }
  };

  stateSwitch = function() {
    //debugLog('stateSwitch()')
    // browser history state change by user
    if (isFullScreen()) {
      //debugLog('stateSwitch() -> if isFullScreen()')
      return home();
    } else {
      //debugLog('stateSwitch() -> else')
      return getColorCodeFromUrl('#');
    }
  };

  home = function() {
    //debugLog('home()')
    return disableFullScreenColor('/.');
  };

  pushWindowHistoryState = function(state3) {
    //debugLog('pushWindowHistoryState("' + state3 + '")')
    if (userHistory.length === 0 || click === 1) {
      //debugLog('if userHistory.length == 0 || click == 1')
      click = 0;
      userHistory.push(state3);
      return window.history.pushState(state3, state3, state3);
    }
  };

  onElementClick = function(e) {
    var color, tokens;
    //debugLog('onElementClick(' + e + ')')
    tokens = e.target.getAttribute("href").split("#");
    color = "#" + tokens[1];
    click = 1;
    return enableFullScreenColor(color);
  };

  onScroll = function() {
    var colorsDiv, pixelToBottom;
    //debugLog('onScroll')
    //body = document.body
    colorsDiv = document.getElementById('colors');
    pixelToBottom = colorsDiv.offsetHeight - window.scrollY;
    if (pixelToBottom < window.innerHeight * 2) {
      return createColorGrid();
    }
  };

  getColorCodeFromUrl = function() {
    var query, url;
    //debugLog("getColorCodeFromUrl('#')")
    url = window.location.href;
    if (url.includes('#')) {
      //debugLog("getColorCodeFromUrl -> if url.includes('#')")
      query = '#' + url.split('#')[1];
      return validateHexColorCode(query);
    }
  };

  //endregion

  //#
  //region color
  randomColorCode = function(colorType) {
    //debugLog('randomColorCode(' + colorType + ')')
    colorType = colorType || 'hex';
    if (colorType === 'hex') {
      return '#' + (0x1000000 + (Math.random()) * 0xffffff).toString(16).substr(1, 6);
    }
  };

  createColorGrid = function() {
    var autoColorGrid, i, topColorGrid;
    //debugLog('createColorGrid()')
    i = 0;
    (topColorGrid = function() {})();
    //debugLog('createColorGrid() -> selectedColors()')
    return (autoColorGrid = function() {
      var colorSquares, colors, divArray, randomColor, results;
      //debugLog('createColorGrid() -> autoColors()')
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
    })();
  };

  validateHexColorCode = function(colorCode) {
    var url;
    //debugLog('validateHexColorCode(' + colorCode + ')')
    if (/^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode)) {
      //debugLog('validateHexColorCode(' + colorCode + ') -> ' + colorCode + ' is a valid HEX color code')
      return enableFullScreenColor(colorCode); // return true # 
    } else {
      url = window.location.href;
      return window.history.replaceState(null, null, url.split('#')[0]);
    }
  };

  enableFullScreenColor = function(color) {
    var fullScreenColorDiv;
    //debugLog("enableFullScreenColor(" + color + ")")
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

  createColorPng = function(width, height, colorCode) {
    var canvas, context, image;
    canvas = document.createElement("CANVAS");
    canvas.setAttribute("width", width);
    canvas.setAttribute("height", height);
    context = canvas.getContext("2d");
    context.fillStyle = colorCode;
    context.fillRect(0, 0, width, height);
    image = canvas.toDataURL("image/png");
    image = canvas.toDataURL();
    return image;
  };

  enableFullScreenColorPng = function(color) {
    var png, pngHTML;
    //debugLog("enableFullScreenColor(" + color + ", " + id + ")")
    png = createColorPng(360, 360, color);
    pngHTML = "<img id='colorImage' src='" + png + "' style='position:fixed; width:100vw; height:100vh; image-rendering: pixelated;'>";
    document.body.insertAdjacentHTML('afterbegin', pngHTML);
    return pushWindowHistoryState(color);
  };

  //endregion

  //#
  //region utilFunctions
  isValidColorCode = function(colorCode) {
    return /^#[0-9A-F]{6}$/i.test(colorCode) || /^#([0-9A-F]{3}){1,2}$/i.test(colorCode);
  };

  generateRandomColorCode = function() {
    return '#' + (0x1000000 + (Math.random()) * 0xffffff).toString(16).substr(1, 6);
  };

  colorCodeFromURL = function(url) {
    return '#' + url.split(urlSeperator)[1];
  };

  //endregion
  kickstart();

  //#
  // region service worker
  window.onload = function() {
    'use strict';
    if ('serviceWorker' in navigator) {
      //debugLog 'Service Worker Registered', registration
      navigator.serviceWorker.register('./sw.js').then(function(registration) {}).catch(function(err) {});
    }
  };

  //endregion

  //#
  //region notes

  // NOW
  // url validator redirect 
  // desktop browser fullscreen stutter
  // lighthouse fix
  // sw.js to coffee
  // seperate code to files
  // metatags

  // viewport zoom
  // document.addEventListener('touchmove', function (event) {
  //   if (event.scale !== 1) { event.preventDefault(); }
  // }, false);
  // https://stackoverflow.com/questions/37808180/disable-viewport-zooming-ios-10-safari/50823326

  // png sharing bug 
  // top colors noscript to coffee

  // hide ios tab bar?

  // 5x Touch Menu
  // Bei Fullscreen wird immer zuerst unten eine Menüleiste angezeigt, notch,
  // bei erneutem Klick auf die Farbe wird die Menüleiste ausgeblendet
  // und kann nur über Browser Back zurückgeholt werden, oder 5x Touch...

  // color pwa
  // v1.5.0?

  // cursor
  // https://www.cssscript.com/interacitve-cursor-dot/

  // Backwards compatible, future proof :)

  // Browser-Sync Click Bug
  // https://github.com/BrowserSync/browser-sync/issues/49

  // Cursor
  // https://www.cssscript.com/circle-cursor-pointer/

  // cert & key gitignore + documentation

  //endregion
  //debugLog 'Service Worker Failed to Register', err

}).call(this);
