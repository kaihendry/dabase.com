body  = document.getElementsByTagName("body").item(0);
pre = document.createElement("pre");
ua = document.createTextNode(window.navigator.userAgent + '\n');
hw = document.createTextNode('Screen size: ' + window.screen.width + 'x' + window.screen.height + '\n');
ahw = document.createTextNode('Availible screen size: ' + window.screen.availWidth + 'x' + window.screen.availHeight);

var myWidth = 0, myHeight = 0;
if( typeof( window.innerWidth ) == 'number' ) {
//Non-IE
myWidth = window.innerWidth;
myHeight = window.innerHeight;
} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
//IE 6+ in 'standards compliant mode'
myWidth = document.documentElement.clientWidth;
myHeight = document.documentElement.clientHeight;
} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
//IE 4 compatible
myWidth = document.body.clientWidth;
myHeight = document.body.clientHeight;
}
innerDimensions = document.createTextNode('\nInner dimensions: ' + myWidth  + 'x' + myHeight);

pre.appendChild(ua);
pre.appendChild(hw);
pre.appendChild(ahw);
pre.appendChild(innerDimensions);
body.appendChild(pre);
