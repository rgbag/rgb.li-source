### Hello! ###

cacheName = 'hello-pwa'
filesToCache = [
  '/manifest.json'
  '/favicon.ico'
  '/index.html'
  '/img/icon.png'
  '/app2/manifest.json'
  '/app2/favicon.ico'
  '/app2/index.html'
  '/app2/img/icon.png'
]

### Start the service worker and cache all of the app's content ###

self.addEventListener 'install', (e) ->
  e.waitUntil caches.open(cacheName).then((cache) ->
    cache.addAll filesToCache
  )
  return

### Serve cached content when offline ###

self.addEventListener 'fetch', (e) ->
  e.respondWith caches.match(e.request).then((response) ->
    response or fetch(e.request)
  )
  return