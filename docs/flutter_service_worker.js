'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "fc15630ee5a26f0b109b1a4d07656e3d",
"version.json": "427e00f7f92a3e7b39ffe54af7ac17d9",
"splash/img/light-background.png": "bb8b6aaedda12ae055148a5534586461",
"splash/img/dark-background.png": "bb8b6aaedda12ae055148a5534586461",
"index.html": "2a4fccdcb5eade60977a0b5a66cf8ff1",
"/": "2a4fccdcb5eade60977a0b5a66cf8ff1",
"main.dart.js": "b8fb3750d77b6b12b05ebf2c88c6c23d",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "52d7e5adcb3568942fa43553a8bbfdfd",
"main.dart.mjs": "fa9dc3bba88e81e1a85c56d1adc91c49",
"icons/Icon-192.png": "e5c8c03f980e43621bbb1694dc41128f",
"icons/Icon-maskable-192.png": "e5c8c03f980e43621bbb1694dc41128f",
"icons/Icon-maskable-512.png": "e195be69e692da538c488a2d054ab695",
"icons/Icon-512.png": "e195be69e692da538c488a2d054ab695",
"manifest.json": "39eb75da7f68d63df2dc2cf11e27f9b8",
"main.dart.wasm": "1495f90ec08804eb72ce32faedbd7e07",
"assets/AssetManifest.json": "9fc545d746b22ab321649478a6ebf196",
"assets/NOTICES": "1971a4f8e0d3613c0114260850ea4af4",
"assets/FontManifest.json": "5c06c501c7d5b52805c83b3876c27986",
"assets/AssetManifest.bin.json": "ef8c3e1cb53869ca683f53f5ec3c5bfd",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "61b17edc0bd9e94e01119212929b40d5",
"assets/fonts/MaterialIcons-Regular.otf": "1b5e2a8212f9c82c939137143cfc0fb3",
"assets/assets/icon.png": "48eb5d80271f7257b9e79767182a2051",
"assets/assets/splash_icon.png": "163caa8742c79dd56b38a5add95e4a51",
"assets/assets/splash.png": "bb8b6aaedda12ae055148a5534586461",
"assets/assets/videos/josip.mp4": "5a29f56ef8991feaf4149fec86dc8617",
"assets/assets/audio/welcome_to_balun.mp3": "3d3b7ddbfbe8633883b13f65f9336031",
"assets/assets/icons/match_date_time.png": "7cf4b68476acb5a095822189a15b579c",
"assets/assets/icons/globe_color.png": "d796836f3d55afc632dbda01318e04bd",
"assets/assets/icons/ball_navigation.png": "ccb168616129d81653561e11c03a3228",
"assets/assets/icons/red_card.png": "7e2e2c6f27530503eb5ccbf4476064f6",
"assets/assets/icons/match_league.png": "86b0dbcd7c30034cc016c9b84f8c4d2f",
"assets/assets/icons/match_status.png": "3d46c2718cab0f65044fd142be277c60",
"assets/assets/icons/ball.png": "1f36fc04f28f17a6c98e2877b675faea",
"assets/assets/icons/mail.png": "3a2ca60a007f61654b930a3290f41c69",
"assets/assets/icons/website.png": "9eca0c01f43df271b372174fe10910e9",
"assets/assets/icons/settings.png": "b89047ff0471911c8f049a5bc28fa27f",
"assets/assets/icons/work_in_progress.png": "75464e09a7f62b14d7595dbbfdd9c1fe",
"assets/assets/icons/assist.png": "568f1203462cc72203eaa8983d6b2b2d",
"assets/assets/icons/var.png": "5ec2f6526185e167483f7bb3ceab5ffd",
"assets/assets/icons/theme.png": "6328b6ac32f1da8a9a085f96358bd91a",
"assets/assets/icons/player_in.png": "85e5e1e1fc631b0b1261078956a2c286",
"assets/assets/icons/placeholder_icon.png": "6e8f453c15d5f6d08b4eca4cf1477d04",
"assets/assets/icons/placeholder_team.png": "1ee5b5d507cfb7e8f21b36cfdb19dc24",
"assets/assets/icons/search.png": "750e894737ac00479afcdc0d64006800",
"assets/assets/icons/match_venue.png": "1a36c95676f264b30878eaac2b29a90f",
"assets/assets/icons/cards.png": "bc3a93e30b7e6e97276a980becc212f3",
"assets/assets/icons/favorite_no.png": "d88db0fbb5a55055311cfaefc74d9e18",
"assets/assets/icons/error.png": "2620a26bcf728f8ff00fcf5e4e0fb84d",
"assets/assets/icons/notifications.png": "44bde081162a2578b1ed0e0e661de248",
"assets/assets/icons/player_out.png": "cfc323a17e18e0a0ef7383afd2626f85",
"assets/assets/icons/favorite_yes.png": "7dd045a8dc0e884b0a49f53abf22d2d0",
"assets/assets/icons/globe.png": "d0b15f63d30d90b085bbdaa5c77ef757",
"assets/assets/icons/calendar.png": "db041557dbfd68a3527f26616de89a06",
"assets/assets/icons/placeholder_player.png": "d3d1129d0ceeac80551d387efd37547d",
"assets/assets/icons/referee.png": "665a83084d5a20efc447ce0ab0e85acf",
"assets/assets/icons/missed_penalty.png": "5fd7ffbd7e467d85b61a2cef594a5131",
"assets/assets/icons/language.png": "55c5f2c18f63a6324b19894b0623239a",
"assets/assets/icons/match_round.png": "3fc67a82d1c026fec182932007d2599f",
"assets/assets/icons/youtube.png": "82fe05fe845a441bce2688174c7c7de0",
"assets/assets/icons/about.png": "dce07ae3783eb533f545e778f63e31b4",
"assets/assets/icons/programming.png": "2f92de4e27f7c0316f08c87960b6b185",
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
"assets/assets/translations/en.json": "c2bee6dd7a79e8de2625ed0cf5ee1f07",
"assets/assets/translations/hr.json": "9e9080b142808f5d8a8151583c794ffc",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
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
