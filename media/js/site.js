$(function () {
  var _navClicked = false,
    defaultWidth = 700,
    lastWidth = defaultWidth;

  // Handle open/close responsive to default bug.
  $(window).resize(function() {
    var newWidth = $(window).width();

    if (lastWidth < newWidth &&
        lastWidth < defaultWidth &&
        defaultWidth < newWidth) {

      // Crossed threshold getting larger.
      // Manually reset to starting point.
      $('.btn.btn-navbar')
        .removeClass("collapsed");

      $('.nav-collapse')
        .removeClass("collapse")
        .removeClass("in")
        .css("height", "auto")
        .show();

      _navClicked = false;

    } else if (newWidth < lastWidth &&
               newWidth < defaultWidth &&
               defaultWidth < lastWidth) {

      // Crossed threshold getting smaller.
      $('.nav-collapse').hide();
      _navClicked = false;
   }

    lastWidth = newWidth;
  });

  // // Fix collapse to properly open / close.
  // $('.btn.btn-navbar').live('click', function () {
  //   // First time doesn't open correctly. Manually do this.
  //   // See: https://github.com/twitter/bootstrap/issues/3184
  //   if (!_navClicked) {
  //     _navClicked = true;
  //     $('.nav-collapse').show();
  //     return;
  //   }
  //   $('.nav-collapse').toggle();
  // });

  $('.nav-collapse a[data-toggle]').click(function () {
    $('.nav-collapse').css('height', '100%');
  });
});