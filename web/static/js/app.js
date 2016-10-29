var Elm = require('../elm/src/Funnel.elm');
var elmDiv = document.querySelector('.chartContainer');
var funnel = elmDiv.getAttribute('data-funnel');
console.log(JSON.parse(funnel))
var elmApp = Elm.Funnel.embed(elmDiv, JSON.parse(funnel));
