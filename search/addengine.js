function addEngine(){
if ((typeof window.sidebar === "object") &&
(typeof window.sidebar.addSearchEngine === "function")) {
window.sidebar.addSearchEngine(
"http://del.icio.us/search/delicious.src",
"http://del.icio.us/static/img/search/delicious.gif",
"delicious",
'Web' );
}}
