$(document).ready(function () {
  a = $('#slideshow').children()
  a.hide()
  a.first().fadeIn()
  setInterval('imageGlider()', 2000)
});

function imageGlider() {
  current_img = $('#slideshow').find(':visible');
  if (current_img.next().length > 0) {
    current_img.fadeOut(400, function() {
      current_img.next().fadeIn(1500)
    });
  } else {
      current_img.fadeOut(400, function() {
        $('#slideshow img').first().fadeIn(1500)
      });
  }
}