"use strict";

$(document).ready(function () {
  svg4everybody({});
  isShowChildMenuInSidebar();
  adaptive();
});

function adaptive() {
  var widthClient = document.documentElement.getBoundingClientRect().width;
  var $sidebarNewsFrame = $('#slider_news');
  var $sidebarNewsWrap = $sidebarNewsFrame.parent();
  var $sidebarSliderFrame = $('#sidebar_slider');
  var $sidebarSliderWrap = $sidebarSliderFrame.parent();
  sliderOption($sidebarSliderFrame, $sidebarSliderWrap.find('.scrollbar'));
  var $sliderPortfolioFrame = $('#slider_portfolio');
  var $sliderPortfolioWrap = $sliderPortfolioFrame.parent();
  sliderOption($sliderPortfolioFrame, $sliderPortfolioWrap.find('.scrollbar'));

  if (widthClient <= 900) {
    headerFirstAdaptive900();
    footerAdaptive900();
  }

  if (widthClient <= 767) {
    sliderOption($sidebarNewsFrame, $sidebarNewsWrap.find('.scrollbar'));
  }

  if (widthClient <= 600) {
    footerAdaptive600();
  }

  var width = null,
      oldWith = null;
  $(window).resize(function () {
    var coordinates = document.documentElement.getBoundingClientRect();
    width = coordinates.width;
    $sliderPortfolioFrame.sly('reload');
    $sidebarSliderFrame.sly('reload');

    if (width > 767 && oldWith < width) {
      $sidebarNewsFrame.sly('destroy');
    }

    if (width <= 900 && oldWith > width) {
      headerFirstAdaptive900();
      footerAdaptive900();
    }

    if (width > 900 && oldWith < width) {
      headerFirstAdaptiveMore900();
      footerAdaptiveMore900();
    }

    if (width <= 767 && oldWith > width) {
      sliderOption($sidebarNewsFrame, $sidebarNewsWrap.find('.scrollbar'));
    }

    if (width <= 767) {
      $sidebarNewsFrame.sly('reload');
    }

    if (width <= 600 && oldWith > width) {
      footerAdaptive600();
    }

    if (width > 600 && oldWith < width) {
      footerAdaptiveMore600();
    }

    oldWith = coordinates.width;
  });
}

function headerFirstAdaptive900() {
  if (!$('.navigation .toolbar_first').length) $('.items_first_nav .navigation').prepend($('.toolbar_first'));
  $('.navigation>.items').hide();
}

function headerFirstAdaptiveMore900() {
  if (!$('.items_first_nav>.toolbar_first').length) $('.header_first .items_first_nav').prepend($('.navigation>.toolbar'));
  $('.navigation>.items').show();
}

function footerAdaptive900() {
  $('.items_adaptive_768').append($('.footer_navigation'));
  $('.copyright_adaptive_768').append($('.item_copyright'));
}

function footerAdaptiveMore900() {
  $('.item_navigation_socials-copyright').prepend($('.footer_navigation'));
  $('.item_navigation_socials-copyright>.items_socials-copyright').append($('.item_copyright'));
}

function footerAdaptive600() {
  $('.footer .container-xl').prepend($('.item_subscribe'));
  $('.footer .item_subscribe').removeClass('item');
}

function footerAdaptiveMore600() {
  $('.footer .item_subscribe').addClass('item');
  $('.footer .container-xl>.items').prepend($('.footer .container-xl>.item_subscribe'));
}

function isShowChildMenuInSidebar() {
  $('.sidebar_navigation .toggle_btn, .sidebar_navigation .cursor>a, .footer_navigation .toggle_btn, .footer_navigation .cursor>a').on('click', function (e) {
    e.preventDefault();
    $(this).parent().toggleClass('active');
  });
} // forEach IE 11


if ('NodeList' in window && !NodeList.prototype.forEach) {
  console.info('polyfill for IE11');

  NodeList.prototype.forEach = function (callback, thisArg) {
    thisArg = thisArg || window;

    for (var i = 0; i < this.length; i++) {
      callback.call(thisArg, this[i], i, this);
    }
  };
} // closest IE 11


(function () {
  if (!Element.prototype.closest) {
    Element.prototype.closest = function (css) {
      var node = this;

      while (node) {
        if (node.matches(css)) return node;else node = node.parentElement;
      }

      return null;
    };
  }
})(); // matches IE 11


(function () {
  if (!Element.prototype.matches) {
    Element.prototype.matches = Element.prototype.matchesSelector || Element.prototype.webkitMatchesSelector || Element.prototype.mozMatchesSelector || Element.prototype.msMatchesSelector;
  }
})(); //Array.form IE 11


if (!Array.from) {
  Array.from = function (object) {
    'use strict';

    return [].slice.call(object);
  };
}