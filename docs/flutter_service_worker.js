'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "429359f8530fba69dbb2e7ad4876e743",
"version.json": "b966157689807d06325f65940ef56b11",
"splash/img/light-background.png": "bb8b6aaedda12ae055148a5534586461",
"splash/img/dark-background.png": "bb8b6aaedda12ae055148a5534586461",
"index.html": "2a4fccdcb5eade60977a0b5a66cf8ff1",
"/": "2a4fccdcb5eade60977a0b5a66cf8ff1",
"main.dart.js": "25fff1eaeebe0ada8d91ec8543518278",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "52d7e5adcb3568942fa43553a8bbfdfd",
"main.dart.mjs": "0396a392d08e6d4ed9ece092c7062182",
"icons/Icon-192.png": "e5c8c03f980e43621bbb1694dc41128f",
"icons/Icon-maskable-192.png": "e5c8c03f980e43621bbb1694dc41128f",
"icons/Icon-maskable-512.png": "e195be69e692da538c488a2d054ab695",
"icons/Icon-512.png": "e195be69e692da538c488a2d054ab695",
"manifest.json": "39eb75da7f68d63df2dc2cf11e27f9b8",
"main.dart.wasm": "411162930f516fab9317408950476c0c",
"assets/AssetManifest.json": "b0f2138d5c877626ec05bf1907805ca2",
"assets/NOTICES": "f627767589d6ef5aea2cf238490092f6",
"assets/FontManifest.json": "5c06c501c7d5b52805c83b3876c27986",
"assets/AssetManifest.bin.json": "9e34d25b38ac24b8c594c816c68bbe23",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "7ccd5f7d2c6b5ec375af0de408d2ff53",
"assets/fonts/MaterialIcons-Regular.otf": "a67a490712b5984307670d8377124f43",
"assets/assets/icon.png": "48eb5d80271f7257b9e79767182a2051",
"assets/assets/splash_icon.png": "163caa8742c79dd56b38a5add95e4a51",
"assets/assets/splash.png": "bb8b6aaedda12ae055148a5534586461",
"assets/assets/audio/welcome_to_balun.mp3": "3d3b7ddbfbe8633883b13f65f9336031",
"assets/assets/icons/match_date_time.png": "7cf4b68476acb5a095822189a15b579c",
"assets/assets/icons/globe_color.png": "d796836f3d55afc632dbda01318e04bd",
"assets/assets/icons/ball_navigation.png": "ccb168616129d81653561e11c03a3228",
"assets/assets/icons/red_card.png": "7e2e2c6f27530503eb5ccbf4476064f6",
"assets/assets/icons/match_league.png": "86b0dbcd7c30034cc016c9b84f8c4d2f",
"assets/assets/icons/match_status.png": "3d46c2718cab0f65044fd142be277c60",
"assets/assets/icons/ball.png": "1f36fc04f28f17a6c98e2877b675faea",
"assets/assets/icons/assist.png": "568f1203462cc72203eaa8983d6b2b2d",
"assets/assets/icons/var.png": "5ec2f6526185e167483f7bb3ceab5ffd",
"assets/assets/icons/player_in.png": "85e5e1e1fc631b0b1261078956a2c286",
"assets/assets/icons/placeholder_icon.png": "6e8f453c15d5f6d08b4eca4cf1477d04",
"assets/assets/icons/placeholder_team.png": "1ee5b5d507cfb7e8f21b36cfdb19dc24",
"assets/assets/icons/search.png": "750e894737ac00479afcdc0d64006800",
"assets/assets/icons/match_venue.png": "1a36c95676f264b30878eaac2b29a90f",
"assets/assets/icons/cards.png": "bc3a93e30b7e6e97276a980becc212f3",
"assets/assets/icons/favorite_no.png": "d88db0fbb5a55055311cfaefc74d9e18",
"assets/assets/icons/error.png": "2620a26bcf728f8ff00fcf5e4e0fb84d",
"assets/assets/icons/player_out.png": "cfc323a17e18e0a0ef7383afd2626f85",
"assets/assets/icons/favorite_yes.png": "7dd045a8dc0e884b0a49f53abf22d2d0",
"assets/assets/icons/globe.png": "d0b15f63d30d90b085bbdaa5c77ef757",
"assets/assets/icons/calendar.png": "db041557dbfd68a3527f26616de89a06",
"assets/assets/icons/placeholder_player.png": "d3d1129d0ceeac80551d387efd37547d",
"assets/assets/icons/referee.png": "665a83084d5a20efc447ce0ab0e85acf",
"assets/assets/icons/missed_penalty.png": "5fd7ffbd7e467d85b61a2cef594a5131",
"assets/assets/icons/match_round.png": "3fc67a82d1c026fec182932007d2599f",
"assets/assets/icons/youtube.png": "82fe05fe845a441bce2688174c7c7de0",
"assets/assets/icons/injury.png": "d8416fe351afb81f3a6acef044d892f3",
"assets/assets/icons/back.png": "003d9104cf5e71acece78e1aa60906a5",
"assets/assets/icons/placeholder_league.png": "208a903ceff537df05484b621413b0a4",
"assets/assets/icons/yellow_card.png": "045dfe24ef7572c987a7fcb568c69868",
"assets/assets/fonts/Lufga500.ttf": "9ab833326b202fb55eb336db57aa3508",
"assets/assets/fonts/Lufga700.ttf": "adecc4bca5b2a9687481c342a4fe9f40",
"assets/assets/fonts/Lufga300.ttf": "1ddf17687f8773fda121f4ef0e6a9885",
"assets/assets/fonts/Lufga100.ttf": "d5d5c39332e5a1d490334bf508cb80f5",
"assets/assets/fonts/Lufga600.ttf": "1e053b4805d075f403dd3e44a3d4ec31",
"assets/assets/fonts/Lufga400.ttf": "9df35b2045f6e32dcfa5bbc421ed05b1",
"assets/assets/fonts/Lufga200.ttf": "40e1d2ea9bd0e6f6145c471b8d2258d8",
"assets/assets/fonts/Lufga800.ttf": "c75c443b141cd41d4c93ebf9e4b9c4db",
"assets/assets/fonts/Lufga900.ttf": "b9752220c09f69872de74ee3173f26d5",
"assets/assets/translations/en.json": "a123a1ec26dbf6cbdb2844b6be8db43e",
"assets/assets/translations/hr.json": "d9e2bc2592b49c999d0d6fd815d89e54",
"canvaskit/skwasm_st.js": "7df9d8484fef4ca8fff6eb4f419a89f8",
"canvaskit/skwasm.js": "9c817487f9f24229450747c66b9374a6",
"canvaskit/skwasm.js.symbols": "86e2c491901be286643b22ecab174245",
"canvaskit/canvaskit.js.symbols": "9cd6c6f6517e7d232456285d2e0f4b9a",
"canvaskit/skwasm.wasm": "ea23b36a4e9108cc6c4dfd12fc3fe28c",
"canvaskit/chromium/canvaskit.js.symbols": "e878fd5eeae47b666d050659717fe4c4",
"canvaskit/chromium/canvaskit.js": "9dc7a140b1f0755e6321e9c61b9bd4d9",
"canvaskit/chromium/canvaskit.wasm": "2014f27e70ce7b7b575f8498fd6c45d1",
"canvaskit/skwasm_st.js.symbols": "25c9845221ee0dd39b173a8caf499c4b",
"canvaskit/canvaskit.js": "8cf6e87eff144e2453a9640bfa1a4ad0",
"canvaskit/canvaskit.wasm": "4ea42381471802a2faf8401a6ad48526",
"canvaskit/skwasm_st.wasm": "a45e6d297c0d4c452d7a7ebb5cc56624"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
