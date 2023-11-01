// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

$(document).ready(function() {
  var textarea = $("#autoresize")
  textarea.on("input", function() {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
  });
});