var Elm = require('../elm/Chart.elm');
var elmDiv = document.querySelector('.chartContainer');
var steps = elmDiv.getAttribute('data-steps');
var elmApp = Elm.App.embed(elmDiv, {
  steps: JSON.parse(steps),
});
