"use strict";

$(document).ready(function () {
  svg4everybody({});
  isShowChildMenuInSidebar();
  adaptive();
  initHeightForMasonry();
  increment();
});

function increment() {
  $('#inputCount>.btn_minus').on('click', function () {
    var inputVal = Number($(this).next().val() || 0);
    if (inputVal > 0) inputVal -= 1;
    $(this).next().val(inputVal);
  });
  $('#inputCount>.btn_plus').on('click', function () {
    var inputVal = Number($(this).prev().val() || 0);
    inputVal += 1;
    $(this).prev().val(inputVal);
  });
}

function initHeightForMasonry() {
  var height = $('.persent-size').height();
  $('.persent-size-x2').css({
    'height': height * 2 + 44
  });
}

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

  if (widthClient <= 1439) {
    catalogModalAdaptive1439();
  }

  if (widthClient <= 900) {
    headerFirstAdaptive900();
    footerAdaptive900();
  }

  if (widthClient <= 767) {
    sliderOption($sidebarNewsFrame, $sidebarNewsWrap.find('.scrollbar'));
    catalogModalAdaptive767();
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
    initHeightForMasonry();

    if (width <= 1439 && oldWith > width) {
      catalogModalAdaptive1439();
    }

    if (width >= 1439 && oldWith < width) {
      catalogModalAdaptiveMore1439();
    }

    if (width > 767 && oldWith < width) {
      $sidebarNewsFrame.sly('destroy');
      catalogModalAdaptive767More();
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
      catalogModalAdaptive767();
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

function catalogModalAdaptive767More() {
  $('.accordion .card').each(function (i, elem) {
    if (i !== 0) {
      console.log($(this).find('.card-body .items .count-m2'));
      $(this).find('.card-body .items .count-m2').after($(this).find('.card-body .footer .total'));
    }
  });
}

function catalogModalAdaptive767() {
  $('.accordion .card').each(function (i, elem) {
    if (i !== 0) {
      $(this).find('.card-body .items .total').prependTo($(this).find('.card-body .footer'));
    }
  });
}

function catalogModalAdaptive1439() {
  if (!$('.product_modal_content>.item_slider>.header').length) {
    $('.product_modal_content>.item_option>.header').prependTo($('.product_modal_content>.item_slider'));
    $('.accordion .collapse').html("\n        <div class=\"card-body\">\n          <div class=\"header\">\n            <div class=\"count\">\u041A\u043E\u043B\u0438\u0447\u0435\u0441\u0442\u0432\u043E \u0432 \u0448\u0442.</div>\n            <div class=\"count-m2\">\u041A\u043E\u043B\u0438\u0447\u0435\u0441\u0442\u0432\u043E \u0432 \u043C2.</div>\n            <div class=\"total\">\u0421\u0443\u043C\u043C\u0430</div>\n            <div class=\"delete\">&nbsp;</div>\n          </div>\n          <div class=\"items\"></div>\n          <div class=\"footer\"></div>\n        </div>\n    ");
    $('.accordion .card').each(function (i, elem) {
      if (i !== 0) {
        $(this).find('.card-header .items .count,' + '.card-header .items .count-m2,' + '.card-header .items .total,' + '.card-header .items .delete').prependTo($(this).find('.card-body .items'));
      }
    });
  }
}

function catalogModalAdaptiveMore1439() {
  if (!$('.product_modal_content>.item_option>.header').length) {
    $('.product_modal_content>.item_slider>.header').prependTo($('.product_modal_content>.item_option'));
    $('.accordion .card').each(function (i, elem) {
      if (i !== 0) {
        $(this).find('.card-body .items .count,' + '.card-body .items .count-m2,' + '.card-body .items .total,' + '.card-body .items .delete').appendTo($(this).find('.card-header .items'));
      }
    });
    $('.accordion .collapse .card-body').remove();
  }
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