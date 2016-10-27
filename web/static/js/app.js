var Elm = require('../elm/src/Funnel.elm');
var elmDiv = document.querySelector('.chartContainer');
var steps = elmDiv.getAttribute('data-steps');
var elmApp = Elm.Funnel.embed(elmDiv, {
  steps: JSON.parse(steps),
});
