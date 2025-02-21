// Compiles a dart2wasm-generated main module from `source` which can then
// instantiatable via the `instantiate` method.
//
// `source` needs to be a `Response` object (or promise thereof) e.g. created
// via the `fetch()` JS API.
export async function compileStreaming(source) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(
      await WebAssembly.compileStreaming(source, builtins), builtins);
}

// Compiles a dart2wasm-generated wasm modules from `bytes` which is then
// instantiatable via the `instantiate` method.
export async function compile(bytes) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(await WebAssembly.compile(bytes, builtins), builtins);
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export async function instantiate(modulePromise, importObjectPromise) {
  var moduleOrCompiledApp = await modulePromise;
  if (!(moduleOrCompiledApp instanceof CompiledApp)) {
    moduleOrCompiledApp = new CompiledApp(moduleOrCompiledApp);
  }
  const instantiatedApp = await moduleOrCompiledApp.instantiate(await importObjectPromise);
  return instantiatedApp.instantiatedModule;
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export const invoke = (moduleInstance, ...args) => {
  moduleInstance.exports.$invokeMain(args);
}

class CompiledApp {
  constructor(module, builtins) {
    this.module = module;
    this.builtins = builtins;
  }

  // The second argument is an options object containing:
  // `loadDeferredWasm` is a JS function that takes a module name matching a
  //   wasm file produced by the dart2wasm compiler and returns the bytes to
  //   load the module. These bytes can be in either a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`.
  async instantiate(additionalImports, {loadDeferredWasm} = {}) {
    let dartInstance;

    // Prints to the console
    function printToConsole(value) {
      if (typeof dartPrint == "function") {
        dartPrint(value);
        return;
      }
      if (typeof console == "object" && typeof console.log != "undefined") {
        console.log(value);
        return;
      }
      if (typeof print == "function") {
        print(value);
        return;
      }

      throw "Unable to print message: " + js;
    }

    // Converts a Dart List to a JS array. Any Dart objects will be converted, but
    // this will be cheap for JSValues.
    function arrayFromDartList(constructor, list) {
      const exports = dartInstance.exports;
      const read = exports.$listRead;
      const length = exports.$listLength(list);
      const array = new constructor(length);
      for (let i = 0; i < length; i++) {
        array[i] = read(list, i);
      }
      return array;
    }

    // A special symbol attached to functions that wrap Dart functions.
    const jsWrappedDartFunctionSymbol = Symbol("JSWrappedDartFunction");

    function finalizeWrapper(dartFunction, wrapped) {
      wrapped.dartFunction = dartFunction;
      wrapped[jsWrappedDartFunctionSymbol] = true;
      return wrapped;
    }

    // Imports
    const dart2wasm = {
            _1: (x0,x1,x2) => x0.set(x1,x2),
      _2: (x0,x1,x2) => x0.set(x1,x2),
      _6: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._6(f,arguments.length,x0) }),
      _7: x0 => new window.FinalizationRegistry(x0),
      _8: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
      _9: (x0,x1) => x0.unregister(x1),
      _10: (x0,x1,x2) => x0.slice(x1,x2),
      _11: (x0,x1) => x0.decode(x1),
      _12: (x0,x1) => x0.segment(x1),
      _13: () => new TextDecoder(),
      _14: x0 => x0.buffer,
      _15: x0 => x0.wasmMemory,
      _16: () => globalThis.window._flutter_skwasmInstance,
      _17: x0 => x0.rasterStartMilliseconds,
      _18: x0 => x0.rasterEndMilliseconds,
      _19: x0 => x0.imageBitmaps,
      _192: x0 => x0.select(),
      _193: (x0,x1) => x0.append(x1),
      _194: x0 => x0.remove(),
      _197: x0 => x0.unlock(),
      _202: x0 => x0.getReader(),
      _211: x0 => new MutationObserver(x0),
      _222: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _223: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      _226: x0 => new ResizeObserver(x0),
      _229: (x0,x1) => new Intl.Segmenter(x0,x1),
      _230: x0 => x0.next(),
      _231: (x0,x1) => new Intl.v8BreakIterator(x0,x1),
      _306: x0 => x0.close(),
      _307: (x0,x1,x2,x3,x4) => ({type: x0,data: x1,premultiplyAlpha: x2,colorSpaceConversion: x3,preferAnimation: x4}),
      _308: x0 => new window.ImageDecoder(x0),
      _309: x0 => x0.close(),
      _310: x0 => ({frameIndex: x0}),
      _311: (x0,x1) => x0.decode(x1),
      _314: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._314(f,arguments.length,x0) }),
      _315: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._315(f,arguments.length,x0) }),
      _316: (x0,x1) => ({addView: x0,removeView: x1}),
      _317: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._317(f,arguments.length,x0) }),
      _318: f => finalizeWrapper(f, function() { return dartInstance.exports._318(f,arguments.length) }),
      _319: (x0,x1) => ({initializeEngine: x0,autoStart: x1}),
      _320: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._320(f,arguments.length,x0) }),
      _321: x0 => ({runApp: x0}),
      _322: x0 => new Uint8Array(x0),
      _324: x0 => x0.preventDefault(),
      _325: x0 => x0.stopPropagation(),
      _326: (x0,x1) => x0.addListener(x1),
      _327: (x0,x1) => x0.removeListener(x1),
      _328: (x0,x1) => x0.prepend(x1),
      _329: x0 => x0.remove(),
      _330: x0 => x0.disconnect(),
      _331: (x0,x1) => x0.addListener(x1),
      _332: (x0,x1) => x0.removeListener(x1),
      _333: x0 => x0.blur(),
      _334: (x0,x1) => x0.append(x1),
      _335: x0 => x0.remove(),
      _336: x0 => x0.stopPropagation(),
      _340: x0 => x0.preventDefault(),
      _345: (x0,x1) => x0.removeChild(x1),
      _346: (x0,x1) => x0.appendChild(x1),
      _347: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _348: (x0,x1) => x0.appendChild(x1),
      _349: (x0,x1) => x0.transferFromImageBitmap(x1),
      _350: (x0,x1) => x0.appendChild(x1),
      _351: (x0,x1) => x0.append(x1),
      _352: (x0,x1) => x0.append(x1),
      _353: (x0,x1) => x0.append(x1),
      _354: x0 => x0.remove(),
      _355: x0 => x0.remove(),
      _356: x0 => x0.remove(),
      _357: (x0,x1) => x0.appendChild(x1),
      _358: (x0,x1) => x0.appendChild(x1),
      _359: x0 => x0.remove(),
      _360: (x0,x1) => x0.append(x1),
      _361: (x0,x1) => x0.append(x1),
      _362: x0 => x0.remove(),
      _363: (x0,x1) => x0.append(x1),
      _364: (x0,x1) => x0.append(x1),
      _365: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _366: (x0,x1) => x0.append(x1),
      _367: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _368: x0 => x0.remove(),
      _369: (x0,x1) => x0.append(x1),
      _370: x0 => x0.remove(),
      _371: (x0,x1) => x0.append(x1),
      _372: x0 => x0.remove(),
      _373: x0 => x0.remove(),
      _374: x0 => x0.getBoundingClientRect(),
      _375: x0 => x0.remove(),
      _388: (x0,x1) => x0.append(x1),
      _389: x0 => x0.remove(),
      _390: (x0,x1) => x0.append(x1),
      _391: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _392: x0 => x0.preventDefault(),
      _393: x0 => x0.preventDefault(),
      _394: x0 => x0.preventDefault(),
      _395: x0 => x0.preventDefault(),
      _396: (x0,x1) => x0.observe(x1),
      _397: x0 => x0.disconnect(),
      _398: (x0,x1) => x0.appendChild(x1),
      _399: (x0,x1) => x0.appendChild(x1),
      _400: (x0,x1) => x0.appendChild(x1),
      _401: (x0,x1) => x0.append(x1),
      _402: x0 => x0.remove(),
      _403: (x0,x1) => x0.append(x1),
      _404: (x0,x1) => x0.append(x1),
      _405: (x0,x1) => x0.appendChild(x1),
      _406: (x0,x1) => x0.append(x1),
      _407: x0 => x0.remove(),
      _408: (x0,x1) => x0.append(x1),
      _409: x0 => x0.remove(),
      _413: (x0,x1) => x0.appendChild(x1),
      _414: x0 => x0.remove(),
      _417: x0 => x0.preventDefault(),
      _418: (x0,x1) => x0.append(x1),
      _419: x0 => x0.remove(),
      _978: () => globalThis.window.flutterConfiguration,
      _979: x0 => x0.assetBase,
      _985: x0 => x0.debugShowSemanticsNodes,
      _986: x0 => x0.hostElement,
      _987: x0 => x0.multiViewEnabled,
      _988: x0 => x0.nonce,
      _990: x0 => x0.fontFallbackBaseUrl,
      _996: x0 => x0.console,
      _997: x0 => x0.devicePixelRatio,
      _998: x0 => x0.document,
      _999: x0 => x0.history,
      _1000: x0 => x0.innerHeight,
      _1001: x0 => x0.innerWidth,
      _1002: x0 => x0.location,
      _1003: x0 => x0.navigator,
      _1004: x0 => x0.visualViewport,
      _1005: x0 => x0.performance,
      _1008: (x0,x1) => x0.dispatchEvent(x1),
      _1010: (x0,x1) => x0.matchMedia(x1),
      _1012: (x0,x1) => x0.getComputedStyle(x1),
      _1013: x0 => x0.screen,
      _1014: (x0,x1) => x0.requestAnimationFrame(x1),
      _1015: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1015(f,arguments.length,x0) }),
      _1020: (x0,x1) => x0.warn(x1),
      _1022: (x0,x1) => x0.debug(x1),
      _1023: () => globalThis.window,
      _1024: () => globalThis.Intl,
      _1025: () => globalThis.Symbol,
      _1028: x0 => x0.clipboard,
      _1029: x0 => x0.maxTouchPoints,
      _1030: x0 => x0.vendor,
      _1031: x0 => x0.language,
      _1032: x0 => x0.platform,
      _1033: x0 => x0.userAgent,
      _1034: x0 => x0.languages,
      _1035: x0 => x0.documentElement,
      _1036: (x0,x1) => x0.querySelector(x1),
      _1039: (x0,x1) => x0.createElement(x1),
      _1040: (x0,x1) => x0.execCommand(x1),
      _1043: (x0,x1) => x0.createTextNode(x1),
      _1044: (x0,x1) => x0.createEvent(x1),
      _1048: x0 => x0.head,
      _1049: x0 => x0.body,
      _1050: (x0,x1) => x0.title = x1,
      _1053: x0 => x0.activeElement,
      _1055: x0 => x0.visibilityState,
      _1056: x0 => x0.hasFocus(),
      _1057: () => globalThis.document,
      _1058: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1059: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1062: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1062(f,arguments.length,x0) }),
      _1063: x0 => x0.target,
      _1065: x0 => x0.timeStamp,
      _1066: x0 => x0.type,
      _1068: x0 => x0.preventDefault(),
      _1070: (x0,x1,x2,x3) => x0.initEvent(x1,x2,x3),
      _1077: x0 => x0.firstChild,
      _1082: x0 => x0.parentElement,
      _1084: x0 => x0.parentNode,
      _1087: (x0,x1) => x0.removeChild(x1),
      _1088: (x0,x1) => x0.removeChild(x1),
      _1089: x0 => x0.isConnected,
      _1090: (x0,x1) => x0.textContent = x1,
      _1093: (x0,x1) => x0.contains(x1),
      _1099: x0 => x0.firstElementChild,
      _1101: x0 => x0.nextElementSibling,
      _1102: x0 => x0.clientHeight,
      _1103: x0 => x0.clientWidth,
      _1104: x0 => x0.offsetHeight,
      _1105: x0 => x0.offsetWidth,
      _1106: x0 => x0.id,
      _1107: (x0,x1) => x0.id = x1,
      _1110: (x0,x1) => x0.spellcheck = x1,
      _1111: x0 => x0.tagName,
      _1112: x0 => x0.style,
      _1113: (x0,x1) => x0.append(x1),
      _1114: (x0,x1) => x0.getAttribute(x1),
      _1116: x0 => x0.getBoundingClientRect(),
      _1119: (x0,x1) => x0.closest(x1),
      _1123: (x0,x1) => x0.querySelectorAll(x1),
      _1124: x0 => x0.remove(),
      _1126: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1127: (x0,x1) => x0.removeAttribute(x1),
      _1128: (x0,x1) => x0.tabIndex = x1,
      _1130: (x0,x1) => x0.focus(x1),
      _1131: x0 => x0.scrollTop,
      _1132: (x0,x1) => x0.scrollTop = x1,
      _1133: x0 => x0.scrollLeft,
      _1134: (x0,x1) => x0.scrollLeft = x1,
      _1135: x0 => x0.classList,
      _1136: (x0,x1) => x0.className = x1,
      _1142: (x0,x1) => x0.getElementsByClassName(x1),
      _1144: x0 => x0.click(),
      _1146: (x0,x1) => x0.hasAttribute(x1),
      _1149: (x0,x1) => x0.attachShadow(x1),
      _1154: (x0,x1) => x0.getPropertyValue(x1),
      _1155: (x0,x1,x2,x3) => x0.setProperty(x1,x2,x3),
      _1157: (x0,x1) => x0.removeProperty(x1),
      _1159: x0 => x0.offsetLeft,
      _1160: x0 => x0.offsetTop,
      _1161: x0 => x0.offsetParent,
      _1163: (x0,x1) => x0.name = x1,
      _1164: x0 => x0.content,
      _1165: (x0,x1) => x0.content = x1,
      _1183: (x0,x1) => x0.nonce = x1,
      _1188: x0 => x0.now(),
      _1190: (x0,x1) => x0.width = x1,
      _1192: (x0,x1) => x0.height = x1,
      _1196: (x0,x1) => x0.getContext(x1),
      _1275: (x0,x1) => x0.fetch(x1),
      _1276: x0 => x0.status,
      _1277: x0 => x0.headers,
      _1278: x0 => x0.body,
      _1280: x0 => x0.arrayBuffer(),
      _1283: (x0,x1) => x0.get(x1),
      _1285: x0 => x0.read(),
      _1286: x0 => x0.value,
      _1287: x0 => x0.done,
      _1289: x0 => x0.name,
      _1290: x0 => x0.x,
      _1291: x0 => x0.y,
      _1294: x0 => x0.top,
      _1295: x0 => x0.right,
      _1296: x0 => x0.bottom,
      _1297: x0 => x0.left,
      _1306: x0 => x0.height,
      _1307: x0 => x0.width,
      _1308: (x0,x1) => x0.value = x1,
      _1310: (x0,x1) => x0.placeholder = x1,
      _1311: (x0,x1) => x0.name = x1,
      _1312: x0 => x0.selectionDirection,
      _1313: x0 => x0.selectionStart,
      _1314: x0 => x0.selectionEnd,
      _1317: x0 => x0.value,
      _1319: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1323: x0 => x0.readText(),
      _1324: (x0,x1) => x0.writeText(x1),
      _1325: x0 => x0.altKey,
      _1326: x0 => x0.code,
      _1327: x0 => x0.ctrlKey,
      _1328: x0 => x0.key,
      _1329: x0 => x0.keyCode,
      _1330: x0 => x0.location,
      _1331: x0 => x0.metaKey,
      _1332: x0 => x0.repeat,
      _1333: x0 => x0.shiftKey,
      _1334: x0 => x0.isComposing,
      _1335: (x0,x1) => x0.getModifierState(x1),
      _1337: x0 => x0.state,
      _1338: (x0,x1) => x0.go(x1),
      _1341: (x0,x1,x2,x3) => x0.pushState(x1,x2,x3),
      _1342: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
      _1343: x0 => x0.pathname,
      _1344: x0 => x0.search,
      _1345: x0 => x0.hash,
      _1349: x0 => x0.state,
      _1356: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1356(f,arguments.length,x0,x1) }),
      _1358: (x0,x1,x2) => x0.observe(x1,x2),
      _1361: x0 => x0.attributeName,
      _1362: x0 => x0.type,
      _1363: x0 => x0.matches,
      _1368: x0 => x0.matches,
      _1370: x0 => x0.relatedTarget,
      _1371: x0 => x0.clientX,
      _1372: x0 => x0.clientY,
      _1373: x0 => x0.offsetX,
      _1374: x0 => x0.offsetY,
      _1377: x0 => x0.button,
      _1378: x0 => x0.buttons,
      _1379: x0 => x0.ctrlKey,
      _1381: (x0,x1) => x0.getModifierState(x1),
      _1384: x0 => x0.pointerId,
      _1385: x0 => x0.pointerType,
      _1386: x0 => x0.pressure,
      _1387: x0 => x0.tiltX,
      _1388: x0 => x0.tiltY,
      _1390: x0 => x0.getCoalescedEvents(),
      _1392: x0 => x0.deltaX,
      _1393: x0 => x0.deltaY,
      _1394: x0 => x0.wheelDeltaX,
      _1395: x0 => x0.wheelDeltaY,
      _1396: x0 => x0.deltaMode,
      _1402: x0 => x0.changedTouches,
      _1404: x0 => x0.clientX,
      _1405: x0 => x0.clientY,
      _1407: x0 => x0.data,
      _1410: (x0,x1) => x0.disabled = x1,
      _1411: (x0,x1) => x0.type = x1,
      _1412: (x0,x1) => x0.max = x1,
      _1413: (x0,x1) => x0.min = x1,
      _1414: (x0,x1) => x0.value = x1,
      _1415: x0 => x0.value,
      _1416: x0 => x0.disabled,
      _1417: (x0,x1) => x0.disabled = x1,
      _1418: (x0,x1) => x0.placeholder = x1,
      _1419: (x0,x1) => x0.name = x1,
      _1420: (x0,x1) => x0.autocomplete = x1,
      _1421: x0 => x0.selectionDirection,
      _1422: x0 => x0.selectionStart,
      _1423: x0 => x0.selectionEnd,
      _1427: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1432: (x0,x1) => x0.add(x1),
      _1436: (x0,x1) => x0.noValidate = x1,
      _1437: (x0,x1) => x0.method = x1,
      _1438: (x0,x1) => x0.action = x1,
      _1463: x0 => x0.orientation,
      _1464: x0 => x0.width,
      _1465: x0 => x0.height,
      _1467: (x0,x1) => x0.lock(x1),
      _1484: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1484(f,arguments.length,x0,x1) }),
      _1493: x0 => x0.length,
      _1494: (x0,x1) => x0.item(x1),
      _1495: x0 => x0.length,
      _1496: (x0,x1) => x0.item(x1),
      _1497: x0 => x0.iterator,
      _1498: x0 => x0.Segmenter,
      _1499: x0 => x0.v8BreakIterator,
      _1502: x0 => x0.done,
      _1503: x0 => x0.value,
      _1504: x0 => x0.index,
      _1508: (x0,x1) => x0.adoptText(x1),
      _1509: x0 => x0.first(),
      _1510: x0 => x0.next(),
      _1511: x0 => x0.current(),
      _1522: x0 => x0.hostElement,
      _1523: x0 => x0.viewConstraints,
      _1525: x0 => x0.maxHeight,
      _1526: x0 => x0.maxWidth,
      _1527: x0 => x0.minHeight,
      _1528: x0 => x0.minWidth,
      _1529: x0 => x0.loader,
      _1530: () => globalThis._flutter,
      _1532: (x0,x1) => x0.didCreateEngineInitializer(x1),
      _1533: (x0,x1,x2) => x0.call(x1,x2),
      _1534: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1534(f,arguments.length,x0,x1) }),
      _1535: x0 => new Promise(x0),
      _1539: x0 => x0.length,
      _1541: x0 => x0.tracks,
      _1545: x0 => x0.image,
      _1552: x0 => x0.displayWidth,
      _1553: x0 => x0.displayHeight,
      _1554: x0 => x0.duration,
      _1558: x0 => x0.ready,
      _1559: x0 => x0.selectedTrack,
      _1560: x0 => x0.repetitionCount,
      _1561: x0 => x0.frameCount,
      _1605: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1606: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _1607: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1607(f,arguments.length,x0) }),
      _1608: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _1609: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1609(f,arguments.length,x0) }),
      _1610: x0 => x0.send(),
      _1611: () => new XMLHttpRequest(),
      _1617: (x0,x1) => x0.createElement(x1),
      _1622: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _1623: f => finalizeWrapper(f, function(x0,x1,x2) { return dartInstance.exports._1623(f,arguments.length,x0,x1,x2) }),
      _1624: (x0,x1) => x0.append(x1),
      _1625: (x0,x1) => x0.append(x1),
      _1630: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1631: (x0,x1) => x0.removeAttribute(x1),
      _1632: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1634: (x0,x1) => x0.getResponseHeader(x1),
      _1657: (x0,x1) => x0.item(x1),
      _1659: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1660: (x0,x1) => x0.removeAttribute(x1),
      _1661: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1663: x0 => x0.remove(),
      _1664: (x0,x1) => x0.csp = x1,
      _1665: x0 => x0.csp,
      _1666: (x0,x1) => x0.getCookieExpirationDate(x1),
      _1667: x0 => x0.remove(),
      _1675: (x0,x1) => x0.querySelectorAll(x1),
      _1676: (x0,x1) => x0.item(x1),
      _1681: () => globalThis.Sentry.close(),
      _1691: () => globalThis.globalThis,
      _1693: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1694: (x0,x1,x2,x3) => x0.removeEventListener(x1,x2,x3),
      _1695: (x0,x1) => x0.createElement(x1),
      _1709: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1710: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1710(f,arguments.length,x0) }),
      _1711: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1711(f,arguments.length,x0) }),
      _1712: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1712(f,arguments.length,x0) }),
      _1713: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1713(f,arguments.length,x0) }),
      _1714: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1714(f,arguments.length,x0) }),
      _1715: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1715(f,arguments.length,x0) }),
      _1716: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1716(f,arguments.length,x0) }),
      _1717: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1717(f,arguments.length,x0) }),
      _1718: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1718(f,arguments.length,x0) }),
      _1719: x0 => x0.load(),
      _1720: (x0,x1) => x0.setSinkId(x1),
      _1721: (x0,x1) => x0.removeAttribute(x1),
      _1722: x0 => x0.load(),
      _1723: (x0,x1) => x0.end(x1),
      _1725: x0 => x0.play(),
      _1726: x0 => x0.pause(),
      _1727: x0 => x0.decode(),
      _1728: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1729: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _1730: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1730(f,arguments.length,x0) }),
      _1731: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1731(f,arguments.length,x0) }),
      _1732: x0 => x0.send(),
      _1733: () => new XMLHttpRequest(),
      _1734: (x0,x1) => x0.getItem(x1),
      _1736: (x0,x1,x2) => x0.setItem(x1,x2),
      _1740: () => globalThis.removeSplashFromWeb(),
      _1751: x0 => new Array(x0),
      _1753: x0 => x0.length,
      _1755: (x0,x1) => x0[x1],
      _1756: (x0,x1,x2) => x0[x1] = x2,
      _1757: x0 => new Promise(x0),
      _1759: (x0,x1,x2) => new DataView(x0,x1,x2),
      _1761: x0 => new Int8Array(x0),
      _1762: (x0,x1,x2) => new Uint8Array(x0,x1,x2),
      _1763: x0 => new Uint8Array(x0),
      _1769: x0 => new Uint16Array(x0),
      _1771: x0 => new Int32Array(x0),
      _1773: x0 => new Uint32Array(x0),
      _1775: x0 => new Float32Array(x0),
      _1777: x0 => new Float64Array(x0),
      _1778: (o, t) => typeof o === t,
      _1779: (o, c) => o instanceof c,
      _1782: (o,s,v) => o[s] = v,
      _1783: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1783(f,arguments.length,x0) }),
      _1784: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1784(f,arguments.length,x0) }),
      _1785: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1785(f,arguments.length,x0,x1) }),
      _1808: () => Symbol("jsBoxedDartObjectProperty"),
      _1809: (decoder, codeUnits) => decoder.decode(codeUnits),
      _1810: () => new TextDecoder("utf-8", {fatal: true}),
      _1811: () => new TextDecoder("utf-8", {fatal: false}),
      _1812: x0 => new WeakRef(x0),
      _1813: x0 => x0.deref(),
      _1819: Date.now,
      _1820: secondsSinceEpoch => {
        const date = new Date(secondsSinceEpoch * 1000);
        const match = /\((.*)\)/.exec(date.toString());
        if (match == null) {
            // This should never happen on any recent browser.
            return '';
        }
        return match[1];
      },
      _1821: s => new Date(s * 1000).getTimezoneOffset() * 60,
      _1822: s => {
        if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(s)) {
          return NaN;
        }
        return parseFloat(s);
      },
      _1823: () => {
        let stackString = new Error().stack.toString();
        let frames = stackString.split('\n');
        let drop = 2;
        if (frames[0] === 'Error') {
            drop += 1;
        }
        return frames.slice(drop).join('\n');
      },
      _1824: () => typeof dartUseDateNowForTicks !== "undefined",
      _1825: () => 1000 * performance.now(),
      _1826: () => Date.now(),
      _1827: () => {
        // On browsers return `globalThis.location.href`
        if (globalThis.location != null) {
          return globalThis.location.href;
        }
        return null;
      },
      _1828: () => {
        return typeof process != "undefined" &&
               Object.prototype.toString.call(process) == "[object process]" &&
               process.platform == "win32"
      },
      _1829: () => new WeakMap(),
      _1830: (map, o) => map.get(o),
      _1831: (map, o, v) => map.set(o, v),
      _1832: () => globalThis.WeakRef,
      _1844: s => JSON.stringify(s),
      _1845: s => printToConsole(s),
      _1846: a => a.join(''),
      _1847: (o, a, b) => o.replace(a, b),
      _1848: (o, p, r) => o.split(p).join(r),
      _1849: (s, t) => s.split(t),
      _1850: s => s.toLowerCase(),
      _1851: s => s.toUpperCase(),
      _1852: s => s.trim(),
      _1853: s => s.trimLeft(),
      _1854: s => s.trimRight(),
      _1855: (s, n) => s.repeat(n),
      _1856: (s, p, i) => s.indexOf(p, i),
      _1857: (s, p, i) => s.lastIndexOf(p, i),
      _1858: (s) => s.replace(/\$/g, "$$$$"),
      _1859: Object.is,
      _1860: s => s.toUpperCase(),
      _1861: s => s.toLowerCase(),
      _1862: (a, i) => a.push(i),
      _1866: a => a.pop(),
      _1867: (a, i) => a.splice(i, 1),
      _1869: (a, s) => a.join(s),
      _1870: (a, s, e) => a.slice(s, e),
      _1872: (a, b) => a == b ? 0 : (a > b ? 1 : -1),
      _1873: a => a.length,
      _1874: (a, l) => a.length = l,
      _1875: (a, i) => a[i],
      _1876: (a, i, v) => a[i] = v,
      _1878: (o, offsetInBytes, lengthInBytes) => {
        var dst = new ArrayBuffer(lengthInBytes);
        new Uint8Array(dst).set(new Uint8Array(o, offsetInBytes, lengthInBytes));
        return new DataView(dst);
      },
      _1879: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
      _1880: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
      _1881: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
      _1882: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
      _1883: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
      _1884: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
      _1885: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
      _1887: (o, start, length) => new BigInt64Array(o.buffer, o.byteOffset + start, length),
      _1888: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
      _1889: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
      _1890: (t, s) => t.set(s),
      _1891: l => new DataView(new ArrayBuffer(l)),
      _1892: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
      _1894: o => o.buffer,
      _1895: o => o.byteOffset,
      _1896: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
      _1897: (b, o) => new DataView(b, o),
      _1898: (b, o, l) => new DataView(b, o, l),
      _1899: Function.prototype.call.bind(DataView.prototype.getUint8),
      _1900: Function.prototype.call.bind(DataView.prototype.setUint8),
      _1901: Function.prototype.call.bind(DataView.prototype.getInt8),
      _1902: Function.prototype.call.bind(DataView.prototype.setInt8),
      _1903: Function.prototype.call.bind(DataView.prototype.getUint16),
      _1904: Function.prototype.call.bind(DataView.prototype.setUint16),
      _1905: Function.prototype.call.bind(DataView.prototype.getInt16),
      _1906: Function.prototype.call.bind(DataView.prototype.setInt16),
      _1907: Function.prototype.call.bind(DataView.prototype.getUint32),
      _1908: Function.prototype.call.bind(DataView.prototype.setUint32),
      _1909: Function.prototype.call.bind(DataView.prototype.getInt32),
      _1910: Function.prototype.call.bind(DataView.prototype.setInt32),
      _1913: Function.prototype.call.bind(DataView.prototype.getBigInt64),
      _1914: Function.prototype.call.bind(DataView.prototype.setBigInt64),
      _1915: Function.prototype.call.bind(DataView.prototype.getFloat32),
      _1916: Function.prototype.call.bind(DataView.prototype.setFloat32),
      _1917: Function.prototype.call.bind(DataView.prototype.getFloat64),
      _1918: Function.prototype.call.bind(DataView.prototype.setFloat64),
      _1931: () => new XMLHttpRequest(),
      _1932: (x0,x1,x2) => x0.open(x1,x2),
      _1933: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _1934: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _1935: x0 => x0.abort(),
      _1936: x0 => x0.abort(),
      _1937: x0 => x0.abort(),
      _1938: x0 => x0.abort(),
      _1939: (x0,x1) => x0.send(x1),
      _1941: x0 => x0.getAllResponseHeaders(),
      _1943: (o, t) => o instanceof t,
      _1945: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1945(f,arguments.length,x0) }),
      _1946: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1946(f,arguments.length,x0) }),
      _1947: o => Object.keys(o),
      _1948: (ms, c) =>
      setTimeout(() => dartInstance.exports.$invokeCallback(c),ms),
      _1949: (handle) => clearTimeout(handle),
      _1950: (ms, c) =>
      setInterval(() => dartInstance.exports.$invokeCallback(c), ms),
      _1951: (handle) => clearInterval(handle),
      _1952: (c) =>
      queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
      _1953: () => Date.now(),
      _1954: (x0,x1,x2) => x0.transaction(x1,x2),
      _1955: (x0,x1) => x0.objectStore(x1),
      _1956: (x0,x1) => x0.getAllKeys(x1),
      _1957: (x0,x1) => x0.getAll(x1),
      _1959: (x0,x1) => x0.delete(x1),
      _1960: (x0,x1,x2) => x0.put(x1,x2),
      _1961: x0 => x0.clear(),
      _1962: x0 => x0.close(),
      _1964: (x0,x1,x2) => x0.open(x1,x2),
      _1969: (x0,x1) => x0.contains(x1),
      _1970: (x0,x1) => x0.createObjectStore(x1),
      _1971: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1971(f,arguments.length,x0) }),
      _1972: (x0,x1) => x0.contains(x1),
      _1973: (x0,x1) => x0.contains(x1),
      _1974: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1974(f,arguments.length,x0) }),
      _2005: (x0,x1,x2,x3,x4,x5) => ({method: x0,headers: x1,body: x2,credentials: x3,redirect: x4,signal: x5}),
      _2006: (x0,x1,x2) => x0.fetch(x1,x2),
      _2007: (x0,x1) => x0.get(x1),
      _2008: f => finalizeWrapper(f, function(x0,x1,x2) { return dartInstance.exports._2008(f,arguments.length,x0,x1,x2) }),
      _2009: (x0,x1) => x0.forEach(x1),
      _2010: x0 => x0.abort(),
      _2011: () => new AbortController(),
      _2012: x0 => x0.getReader(),
      _2013: x0 => x0.read(),
      _2014: x0 => x0.cancel(),
      _2016: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._2016(f,arguments.length,x0) }),
      _2017: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._2017(f,arguments.length,x0) }),
      _2018: x0 => x0.openCursor(),
      _2019: x0 => x0.continue(),
      _2020: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._2020(f,arguments.length,x0) }),
      _2021: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._2021(f,arguments.length,x0) }),
      _2022: () => new XMLHttpRequest(),
      _2024: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _2027: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._2027(f,arguments.length,x0) }),
      _2028: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._2028(f,arguments.length,x0) }),
      _2034: (x0,x1) => x0.matchMedia(x1),
      _2070: () => globalThis.window.flutter_inappwebview,
      _2076: (x0,x1) => x0.nativeCommunication = x1,
      _2077: (x0,x1) => x0.key(x1),
      _2093: (s, m) => {
        try {
          return new RegExp(s, m);
        } catch (e) {
          return String(e);
        }
      },
      _2094: (x0,x1) => x0.exec(x1),
      _2095: (x0,x1) => x0.test(x1),
      _2096: (x0,x1) => x0.exec(x1),
      _2097: (x0,x1) => x0.exec(x1),
      _2098: x0 => x0.pop(),
      _2100: o => o === undefined,
      _2119: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
      _2121: o => {
        const proto = Object.getPrototypeOf(o);
        return proto === Object.prototype || proto === null;
      },
      _2122: o => o instanceof RegExp,
      _2123: (l, r) => l === r,
      _2124: o => o,
      _2125: o => o,
      _2126: o => o,
      _2127: b => !!b,
      _2128: o => o.length,
      _2131: (o, i) => o[i],
      _2132: f => f.dartFunction,
      _2133: l => arrayFromDartList(Int8Array, l),
      _2134: l => arrayFromDartList(Uint8Array, l),
      _2135: l => arrayFromDartList(Uint8ClampedArray, l),
      _2136: l => arrayFromDartList(Int16Array, l),
      _2137: l => arrayFromDartList(Uint16Array, l),
      _2138: l => arrayFromDartList(Int32Array, l),
      _2139: l => arrayFromDartList(Uint32Array, l),
      _2140: l => arrayFromDartList(Float32Array, l),
      _2141: l => arrayFromDartList(Float64Array, l),
      _2142: x0 => new ArrayBuffer(x0),
      _2143: (data, length) => {
        const getValue = dartInstance.exports.$byteDataGetUint8;
        const view = new DataView(new ArrayBuffer(length));
        for (let i = 0; i < length; i++) {
          view.setUint8(i, getValue(data, i));
        }
        return view;
      },
      _2144: l => arrayFromDartList(Array, l),
      _2145: () => ({}),
      _2146: () => [],
      _2147: l => new Array(l),
      _2148: () => globalThis,
      _2149: (constructor, args) => {
        const factoryFunction = constructor.bind.apply(
            constructor, [null, ...args]);
        return new factoryFunction();
      },
      _2150: (o, p) => p in o,
      _2151: (o, p) => o[p],
      _2152: (o, p, v) => o[p] = v,
      _2153: (o, m, a) => o[m].apply(o, a),
      _2155: o => String(o),
      _2156: (p, s, f) => p.then(s, f),
      _2157: o => {
        if (o === undefined) return 1;
        var type = typeof o;
        if (type === 'boolean') return 2;
        if (type === 'number') return 3;
        if (type === 'string') return 4;
        if (o instanceof Array) return 5;
        if (ArrayBuffer.isView(o)) {
          if (o instanceof Int8Array) return 6;
          if (o instanceof Uint8Array) return 7;
          if (o instanceof Uint8ClampedArray) return 8;
          if (o instanceof Int16Array) return 9;
          if (o instanceof Uint16Array) return 10;
          if (o instanceof Int32Array) return 11;
          if (o instanceof Uint32Array) return 12;
          if (o instanceof Float32Array) return 13;
          if (o instanceof Float64Array) return 14;
          if (o instanceof DataView) return 15;
        }
        if (o instanceof ArrayBuffer) return 16;
        return 17;
      },
      _2158: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI8ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2159: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI8ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2160: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI16ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2161: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI16ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2162: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2163: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2164: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2165: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2166: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF64ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2167: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF64ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2168: s => {
        if (/[[\]{}()*+?.\\^$|]/.test(s)) {
            s = s.replace(/[[\]{}()*+?.\\^$|]/g, '\\$&');
        }
        return s;
      },
      _2171: x0 => x0.index,
      _2172: x0 => x0.groups,
      _2174: (x0,x1) => x0.exec(x1),
      _2176: x0 => x0.flags,
      _2177: x0 => x0.multiline,
      _2178: x0 => x0.ignoreCase,
      _2179: x0 => x0.unicode,
      _2180: x0 => x0.dotAll,
      _2181: (x0,x1) => x0.lastIndex = x1,
      _2182: (o, p) => p in o,
      _2183: (o, p) => o[p],
      _2184: (o, p, v) => o[p] = v,
      _2186: x0 => x0.random(),
      _2187: x0 => x0.random(),
      _2188: (x0,x1) => x0.getRandomValues(x1),
      _2189: () => globalThis.crypto,
      _2191: () => globalThis.Math,
      _2193: Function.prototype.call.bind(Number.prototype.toString),
      _2194: (d, digits) => d.toFixed(digits),
      _2198: () => globalThis.document,
      _2222: x0 => x0.src,
      _2223: (x0,x1) => x0.src = x1,
      _2224: x0 => x0.naturalWidth,
      _2225: x0 => x0.naturalHeight,
      _2250: x0 => x0.status,
      _2251: (x0,x1) => x0.responseType = x1,
      _2253: x0 => x0.response,
      _2301: x0 => x0.readyState,
      _2303: (x0,x1) => x0.timeout = x1,
      _2305: (x0,x1) => x0.withCredentials = x1,
      _2306: x0 => x0.upload,
      _2307: x0 => x0.responseURL,
      _2308: x0 => x0.status,
      _2309: x0 => x0.statusText,
      _2311: (x0,x1) => x0.responseType = x1,
      _2312: x0 => x0.response,
      _2313: x0 => x0.responseText,
      _2326: x0 => x0.loaded,
      _2327: x0 => x0.total,
      _2392: x0 => x0.style,
      _2869: x0 => x0.src,
      _2870: (x0,x1) => x0.src = x1,
      _2873: x0 => x0.name,
      _2874: (x0,x1) => x0.name = x1,
      _2875: x0 => x0.sandbox,
      _2876: x0 => x0.allow,
      _2877: (x0,x1) => x0.allow = x1,
      _2878: x0 => x0.allowFullscreen,
      _2879: (x0,x1) => x0.allowFullscreen = x1,
      _2884: x0 => x0.referrerPolicy,
      _2885: (x0,x1) => x0.referrerPolicy = x1,
      _2999: x0 => x0.error,
      _3000: x0 => x0.src,
      _3001: (x0,x1) => x0.src = x1,
      _3009: (x0,x1) => x0.preload = x1,
      _3010: x0 => x0.buffered,
      _3013: x0 => x0.currentTime,
      _3014: (x0,x1) => x0.currentTime = x1,
      _3015: x0 => x0.duration,
      _3020: (x0,x1) => x0.playbackRate = x1,
      _3033: (x0,x1) => x0.volume = x1,
      _3050: x0 => x0.code,
      _3127: x0 => x0.length,
      _4124: () => globalThis.window,
      _4165: x0 => x0.self,
      _4166: x0 => x0.document,
      _4169: x0 => x0.location,
      _4188: x0 => x0.navigator,
      _4192: x0 => x0.screen,
      _4204: x0 => x0.devicePixelRatio,
      _4445: x0 => x0.indexedDB,
      _4452: x0 => x0.localStorage,
      _4462: x0 => x0.origin,
      _4471: x0 => x0.pathname,
      _4572: x0 => x0.deviceMemory,
      _4576: x0 => x0.platform,
      _4579: x0 => x0.userAgent,
      _4585: x0 => x0.onLine,
      _4799: x0 => x0.length,
      _6784: x0 => x0.target,
      _6826: x0 => x0.signal,
      _6836: x0 => x0.length,
      _6888: x0 => x0.baseURI,
      _6905: () => globalThis.document,
      _6998: x0 => x0.body,
      _7348: x0 => x0.id,
      _7349: (x0,x1) => x0.id = x1,
      _7593: x0 => x0.length,
      _8730: x0 => x0.value,
      _8732: x0 => x0.done,
      _9455: x0 => x0.url,
      _9457: x0 => x0.status,
      _9459: x0 => x0.statusText,
      _9460: x0 => x0.headers,
      _9461: x0 => x0.body,
      _9739: x0 => x0.type,
      _9754: x0 => x0.matches,
      _9765: x0 => x0.availWidth,
      _9766: x0 => x0.availHeight,
      _9771: x0 => x0.orientation,
      _10934: x0 => x0.result,
      _10935: x0 => x0.error,
      _10940: (x0,x1) => x0.onsuccess = x1,
      _10942: (x0,x1) => x0.onerror = x1,
      _10946: (x0,x1) => x0.onupgradeneeded = x1,
      _10967: x0 => x0.version,
      _10968: x0 => x0.objectStoreNames,
      _11040: x0 => x0.key,
      _11043: x0 => x0.value,
      _11614: (x0,x1) => x0.border = x1,
      _11892: (x0,x1) => x0.display = x1,
      _12056: (x0,x1) => x0.height = x1,
      _12746: (x0,x1) => x0.width = x1,
      _13877: () => globalThis.window.flutterCanvasKit,
      _13881: () => globalThis.window.flutterCanvasKit,

    };

    const baseImports = {
      dart2wasm: dart2wasm,
      Math: Math,
      Date: Date,
      Object: Object,
      Array: Array,
      Reflect: Reflect,
      
    };

    const jsStringPolyfill = {
      "charCodeAt": (s, i) => s.charCodeAt(i),
      "compare": (s1, s2) => {
        if (s1 < s2) return -1;
        if (s1 > s2) return 1;
        return 0;
      },
      "concat": (s1, s2) => s1 + s2,
      "equals": (s1, s2) => s1 === s2,
      "fromCharCode": (i) => String.fromCharCode(i),
      "length": (s) => s.length,
      "substring": (s, a, b) => s.substring(a, b),
      "fromCharCodeArray": (a, start, end) => {
        if (end <= start) return '';

        const read = dartInstance.exports.$wasmI16ArrayGet;
        let result = '';
        let index = start;
        const chunkLength = Math.min(end - index, 500);
        let array = new Array(chunkLength);
        while (index < end) {
          const newChunkLength = Math.min(end - index, 500);
          for (let i = 0; i < newChunkLength; i++) {
            array[i] = read(a, index++);
          }
          if (newChunkLength < chunkLength) {
            array = array.slice(0, newChunkLength);
          }
          result += String.fromCharCode(...array);
        }
        return result;
      },
    };


    const deferredLibraryHelper = {
      "loadModule": async (moduleName) => {
        if (!loadDeferredWasm) {
          throw "No implementation of loadDeferredWasm provided.";
        }
        const source = await Promise.resolve(loadDeferredWasm(moduleName));
        const module = await ((source instanceof Response)
            ? WebAssembly.compileStreaming(source, this.builtins)
            : WebAssembly.compile(source, this.builtins));
        return await WebAssembly.instantiate(module, {
          ...baseImports,
          ...additionalImports,
          "wasm:js-string": jsStringPolyfill,
          "module0": dartInstance.exports,
        });
      },
    };

    dartInstance = await WebAssembly.instantiate(this.module, {
      ...baseImports,
      ...additionalImports,
      "deferredLibraryHelper": deferredLibraryHelper,
      "wasm:js-string": jsStringPolyfill,
    });

    return new InstantiatedApp(this, dartInstance);
  }
}

class InstantiatedApp {
  constructor(compiledApp, instantiatedModule) {
    this.compiledApp = compiledApp;
    this.instantiatedModule = instantiatedModule;
  }

  // Call the main function with the given arguments.
  invokeMain(...args) {
    this.instantiatedModule.exports.$invokeMain(args);
  }
}
