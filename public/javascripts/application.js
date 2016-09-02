// Put your application scripts here

	    // Opera 8.0+
const isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
    // Firefox 1.0+
const isFirefox = typeof InstallTrigger !== 'undefined';
    // At least Safari 3+: "[object HTMLElementConstructor]"
const isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
    // Internet Explorer 6-11
const isIE = /*@cc_on!@*/false || !!document.documentMode;
    // Edge 20+
const isEdge = !isIE && !!window.StyleMedia;
    // Chrome 1+
const isChrome = !!window.chrome && !!window.chrome.webstore;
    // Blink engine detection
const isBlink = (isChrome || isOpera) && !!window.CSS;