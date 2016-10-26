var Elm = require('../elm/src/Chart.elm');
var elmDiv = document.querySelector('.chartContainer');
var steps = elmDiv.getAttribute('data-steps');
var elmApp = Elm.Chart.embed(elmDiv, {
  steps: JSON.parse(steps),
});
