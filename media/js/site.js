// Reformat documentation and add in extra Bootstrap goodness.
$(function () {
  'use strict';

  var Transforms,
    // http://www.pinlady.net/PluginDetect/IE/
    IS_IE = /*@cc_on!@*/!1,
    // See: http://tanalin.com/en/articles/ie-version-js/
    IE_GTE_10 = !!window.atob;

  Transforms = {
    background: function () {
      // Short circuit if no backstrech.
      if (!$.backstretch) { return; }

      // Backstretch images from http://www.public-domain-photos.com/
      // - clouds: landscapes/sky/clouds-2-4.htm
      // - sunrise: landscapes/sky/sunrise-3-4.htm
      // - yosemite: travel/yosemite/yosemite-meadows-4.htm
      $.backstretch("../../media/img/bg/sunrise.jpg");
      $(".backstretch").addClass("hidden-phone");
    }
  };

  // Apply transforms.
  Transforms.background();

});
