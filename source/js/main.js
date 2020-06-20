// Generated by CoffeeScript 2.4.1
(function() {
  // # Register Service Worker
  // window.onload = ->
  //     'use strict'
  //     if 'serviceWorker' of navigator
  //         navigator.serviceWorker.register('./sw.js').then((registration) ->
  //             console.log 'Service Worker Registered', registration
  //             return
  //         ).catch (err) ->
  //             console.log 'Service Worker Failed to Register', err
  //             return
  //     return

  //###########################################################
  //region config
  var adjustDisplayState, colorCodeFromURL, createColorGrid, createColorSquare, debugLog, disablefullScreenColor, enablefullScreenColor, generateRandomColorCode, home, isFullScreen, isValidColorCode, nrColorSquares, onElementClick, onPageLoad, setup, urlSeperator, useColorCode, useColorCodeFromQueryURL, windowHistoryPushState;

  urlSeperator = '#';

  nrColorSquares = 1000;

  //###########################################################
  debugLog = true;

  //endregion

  //###########################################################
  debugLog = function(log) {
    if (debugLog) {
      return console.log(log);
    }
  };

  //###########################################################
  onPageLoad = function() {
    debugLog("onPageLoad()");
    setup();
    useColorCodeFromQueryURL();
  };

  //###########################################################
  //region setup
  setup = function() {
    debugLog("setup()");
    createColorGrid();
    //# What is this supposed to do?
    window.addEventListener('popstate', function(e) {
      debugLog('setup() -> popstate event');
      return adjustDisplayState();
    });
  };

  //###########################################################
  //region createColorGrid
  createColorGrid = function() {
    var color, colors, divArray, i, j, ref, square;
    debugLog('createColorGrid()');
    divArray = [];
    colors = document.getElementById('colors');
    for (i = j = 0, ref = nrColorSquares; (0 <= ref ? j <= ref : j >= ref); i = 0 <= ref ? ++j : --j) {
      color = generateRandomColorCode();
      square = createColorSquare(color);
      divArray[i] = square;
      colors.appendChild(square);
    }
  };

  //###########################################################
  createColorSquare = function(color) {
    var el;
    el = document.createElement('div');
    el.style.backgroundColor = color;
    el.className = "color";
    el.setAttribute('href', "" + color);
    el.addEventListener("click", onElementClick); // fixed by Lenny
    return el;
  };

  //###########################################################
  onElementClick = function(event) {
    var color, url;
    debugLog('onElementClick(' + event + ')');
    url = event.target.getAttribute("href");
    if (!url.includes(urlSeperator)) {
      return;
    }
    color = colorCodeFromURL(url);
    enablefullScreenColor(color);
  };

  //endregion

  //###########################################################
  //region displayStateFunctions
  adjustDisplayState = function() {
    var fullScreenColor;
    debugLog('adjustDisplayState()');
    if (isFullScreen()) {
      debugLog('adjustDisplayState() -> if isFullScreen(): ' + isFullScreen());
      home();
    } else {
      fullScreenColor = document.getElementById('fullScreenColor');
      fullScreenColor.style.height = '100vh';
    }
  };

  //###########################################################
  isFullScreen = function() {
    var fullScreenColor, fullScreenState;
    debugLog('isFullScreen()');
    fullScreenColor = document.getElementById('fullScreenColor');
    fullScreenState = 'unknown';
    if (fullScreenColor.style.height = '0px') { //bug? this is always true^^..
      debugLog('isFullScreen() -> fullScreenColor.style.height = "0px"');
      fullScreenState = true;
    } else {
      debugLog('isFullScreen() -> fullScreenColor.style.height = ' + fullScreenColor.style.height);
      fullScreenState = false;
    }
    return fullScreenState;
  };

  //###########################################################
  home = function() {
    debugLog('home()');
    disablefullScreenColor('/.');
  };

  //###########################################################
  windowHistoryPushState = function(state3) {
    debugLog('windowHistoryPushState("' + state3 + '")');
    window.history.pushState(state3, state3, state3);
    debugLog('windowHistoryPushState("' + state3 + '") -> window.history.pushState("' + state3 + '", "' + state3 + '", "' + state3 + '")');
    debugLog('windowHistoryPushState("' + state3 + '") -> window.history.state == ' + window.history.state);
  };

  //###########################################################
  enablefullScreenColor = function(color) {
    var fullScreenColor;
    debugLog("enablefullScreenColor(" + color + ")");
    fullScreenColor = document.getElementById('fullScreenColor');
    fullScreenColor.style.backgroundColor = color;
    fullScreenColor.style.height = '100vh';
    windowHistoryPushState(color);
  };

  //###########################################################
  disablefullScreenColor = function(pushState) {
    var fullScreenColor;
    fullScreenColor = document.getElementById('fullScreenColor');
    fullScreenColor.style.backgroundColor = null;
    fullScreenColor.style.height = '0px';
  };

  //endregion

  //endregion

  //###########################################################
  //region useColorCodeFromURL
  // windowHistoryPushState(pushState)
  useColorCodeFromQueryURL = function() {
    var code, url;
    debugLog('useColorCodeFromQueryURL("' + urlSeperator + '")');
    urlSeperator = urlSeperator || "?";
    url = window.location.href;
    if (!url.includes(urlSeperator)) {
      return;
    }
    debugLog('useColorCodeFromQueryURL -> url.includes(' + urlSeperator + ')');
    code = colorCodeFromURL(url);
    useColorCode(code);
  };

  useColorCode = function(colorCode) {
    debugLog('useColorCode(' + colorCode + ')');
    if (isValidColorCode(colorCode)) {
      debugLog('useColorCode(' + colorCode + ') -> ' + colorCode + ' is a valid HEX color code');
      enablefullScreenColor(colorCode);
    }
  };

  //endregion

  //###########################################################
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

  //###########################################################
  onPageLoad();

}).call(this);
