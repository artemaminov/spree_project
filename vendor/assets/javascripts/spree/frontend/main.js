"use strict";

$(document).ready(function () {
  svg4everybody({});
  isShowChildMenuInSidebar();
  adaptive();
  initHeightForMasonry();
  increment();
});

function controlCalcClearBtn(line) {
  var btn = line.closest('.items').find('.btn_delete');
  if (Number(line.val()) != 0) {
    btn.show();
  } else {
    btn.hide();
  }
}

function calcTotal() {
  var variantCost = 0;
  var totals = $('.card .items .total');
  var final = 0;
  totals.each(function (index) {
    var variantTotalElement = $("#variant-".concat(index, "-total"));
    variantCost = Number(variantTotalElement.data('cost'));
    if (Number.isFinite(variantCost)) {
      final += variantCost;
    }
  });
  $(".calc-total").text("".concat(Number.parseFloat(final).toFixed(2), " \u20BD"));
}

function calc(e) {
  var variantPieces,
      variantSqrMeters,
      variantPallets,
      variantTotal = 0;
  var variant = $(e).data("info");
  var amount = $(e).val();
  var variantPiecesElement = $("#variant-".concat(variant.id, "-pieces"));
  var variantPalletsElement = $("#variant-".concat(variant.id, "-pallets"));
  var variantTotalElement = $("#variant-".concat(variant.id, "-total"));
  var variantAmountType = $("#variant-".concat(variant.id, "-amount-type option:checked")).val();

  switch (variantAmountType) {
    case "WY":
      variantSqrMeters = Number(amount);
      variantPieces = Number(variant.sqrMeterAmount) * variantSqrMeters;
      variantPiecesElement.text("".concat(variantPieces, " \u0448\u0442\u0443\u043A"));
      break;

    case "AL":
      variantPieces = Number(amount);
      variantSqrMeters = Number.parseFloat(variantPieces / Number(variant.sqrMeterAmount)).toFixed(2);
      variantPiecesElement.text("".concat(variantSqrMeters, " \u043C\u0435\u0442\u0440\xB2"));
  }

  variantPallets = Number.parseFloat(variantPieces / Number(variant.palletQuantity)).toFixed(2);
  variantTotal = Number.parseFloat(Number(variant.price) * variantPieces).toFixed(2);
  variantPalletsElement.text("".concat(variantPallets, " \u043F\u043E\u0434\u0434\u043E\u043D\u043E\u0432"));
  variantTotalElement.text("".concat(variantTotal, " \u20BD"));
  variantTotalElement.data('cost', variantTotal);

  controlCalcClearBtn($(e));
  calcTotal();
}

function increment() {
  $('.calc-type').change(function () {
    var input = $(this).closest('.items').find('input.calc-btn');
    calc(input);
  });
  $('input.calc-btn').keyup(function () {
    calc($(this));
  });
  $('.btn_delete').on('click', function () {
    var input = $(this).closest('.items').find('input.calc-btn');
    input.val(0);
    calc(input);
  });
  $('#inputCount>.btn_minus').on('click', function () {
    var input = $(this).next();
    var inputVal = Number(input.val() || 0);
    if (inputVal > 0) inputVal -= 1;
    input.val(inputVal);
    calc(input);
  });
  $('#inputCount>.btn_plus').on('click', function () {
    var input = $(this).prev();
    var inputVal = Number(input.val() || 0);
    inputVal += 1;
    input.val(inputVal);
    calc(input);
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
  var $sliderSimilarProductFrame = $('#slider_similar_product');
  var $sliderSimilarProductWrap = $sliderSimilarProductFrame.parent();
  sliderOption($sliderSimilarProductFrame, $sliderSimilarProductWrap.find('.scrollbar'));

  if (widthClient >= 1300) {
    initSocial();
  }

  if (widthClient <= 1023) {
    productCard1150();
    productCard1023();
  }

  if (widthClient <= 1070) {
    portfolioFilter1070();
  }

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
    productDelivery767();
  }

  if (widthClient <= 600) {
    footerAdaptive600();
    productCard600();
  }

  var width = null,
      oldWith = null;
  $(window).resize(function () {
    var coordinates = document.documentElement.getBoundingClientRect();
    width = coordinates.width;
    $sliderPortfolioFrame.sly('reload');
    $sidebarSliderFrame.sly('reload');
    $sliderPortfolioFrame.sly('reload');
    $sliderSimilarProductFrame.sly('reload');
    initHeightForMasonry();

    if (width >= 1300) {
      initSocial();
    }

    if (width <= 1439 && oldWith > width) {
      catalogModalAdaptive1439();
    }

    if (width >= 1439 && oldWith < width) {
      catalogModalAdaptiveMore1439();
    }

    if (width <= 1070 && oldWith > width) {
      portfolioFilter1070();
    }

    if (width > 1070 && oldWith < width) {
      portfolioFilterMore1070();
    }

    if (width <= 1023 && oldWith > width) {
      productCard1150();
      productCard1023();
    }

    if (width > 1023 && oldWith < width) {
      productCard1150More();
      productCardMore1023();
    }

    if (width <= 900 && oldWith > width) {
      headerFirstAdaptive900();
      footerAdaptive900();
    }

    if (width > 900 && oldWith < width) {
      headerFirstAdaptiveMore900();
      footerAdaptiveMore900();
    }

    if (width > 767 && oldWith < width) {
      $sidebarNewsFrame.sly('destroy');
      catalogModalAdaptive767More();
      productDeliveryMore767();
    }

    if (width <= 767 && oldWith > width) {
      sliderOption($sidebarNewsFrame, $sidebarNewsWrap.find('.scrollbar'));
      catalogModalAdaptive767();
      productDelivery767();
    }

    if (width <= 767) {
      $sidebarNewsFrame.sly('reload');
    }

    if (width <= 600 && oldWith > width) {
      footerAdaptive600();
      productCard600();
    }

    if (width > 600 && oldWith < width) {
      footerAdaptiveMore600();
      productCardMore600();
    }

    oldWith = coordinates.width;
  });
}

function initSocial() {
  var bottomSocial = $(".wrapper>.footer").innerHeight() + $(".wrapper>.section_map").innerHeight();
  $.lockfixed(".socialsList .items", {
    offset: {
      top: 400,
      bottom: bottomSocial - 190
    }
  });
}

function portfolioFilterMore1070() {
  var filterBlock = $(".portfolio-filter");

  if (!filterBlock.find(".item:last-child .title .clear").length) {
    var clearBlock = filterBlock.find(".item:first-child .title .clear");
    filterBlock.find(".item:last-child .title .text").after(clearBlock);
  }
}

function portfolioFilter1070() {
  var filterBlock = $(".portfolio-filter");

  if (!filterBlock.find(".item:first-child .title .clear").length) {
    var clearBlock = filterBlock.find(".item:last-child .title .clear");
    filterBlock.find(".item:first-child .title .text").after(clearBlock);
  }
}

function productDeliveryMore767() {
  if (!$(".accordion-delivery .collapse>.card-body").length) {
    var obj = $('.accordion-delivery .card');
    obj.find(".card-body .items .title").remove();
    obj.find(".card-body .items .kind-of-transport .text .slash").remove();
    obj.each(function () {
      $(this).find('.card-header .items .format').after($(this).find('.card-body .items .count-car'));
      $(this).find('.card-body .items .count .custom-select').after($(this).find('.card-body .items .kind-of-transport .text'));
      $(this).find('.card-header .items .format').after($(this).find('.card-body .items .kind-of-transport'));
      $(this).find('.card-header .items .kind-of-transport').after($(this).find('.card-body .items .count'));
    });
    obj.find(".card-body").remove();
  }
}

function productDelivery767() {
  if (!$('.accordion-delivery .collapse>.card-body').length) {
    $('.accordion-delivery .collapse').html("\n\t\t\t<div class=\"card-body\">\n\t\t\t\t<div class=\"items\"></div>\n\t\t\t</div>\n\t\t");
    $('.accordion-delivery .card').each(function (i) {
      $(this).find('.card-header .items .total').clone().prependTo($(this).find('.card-body .items'));
      $(this).find('.card-header .items .count-car').prependTo($(this).find('.card-body .items'));
      $(this).find('.card-header .items .kind-of-transport').prependTo($(this).find('.card-body .items'));
      $("<div class='title'>Тип транспорта</div>").prependTo($(this).find('.card-body .items'));
      $(this).find('.card-header .items .count').prependTo($(this).find('.card-body .items'));
      $("<div class='title'>Количество:</div>").prependTo($(this).find('.card-body .items'));
      $(this).find('.card-body .items .count .text').appendTo($(this).find('.card-body .items .kind-of-transport'));
      $(this).find('.card-body .items .count-car').appendTo($(this).find('.card-body .items .kind-of-transport .text'));
      $(this).find('.card-body .items .kind-of-transport .text .count-car').html("<span class='slash'>/</span>" + $(this).find('.card-body .items .kind-of-transport .text .count-car').html());
      $(this).find('.card-body .items .total').html("<span class='title'>Сумма: </span>" + $(this).find('.card-body .items .total').html());
    });
  }
}

function productCardMore600() {
  if ($(".card-body .header>.price_metr").length) {
    $(".card-product_bottom .card").each(function (i) {
      $(this).find(".card-body .header").find(".price_metr>span:first-child").remove();
      $(this).find(".card-body .header").find(".price_metr>span:last").remove();
      $(this).find(".card-body .items>.count>select").after($(this).find(".card-body .items>.text"));
      $(this).find(".card-body>.header>.price_metr").remove();
    });
  }
}

function productCard600() {
  if ($('.card-body .items .count>.text').length) {
    $(".card-product_bottom .card").each(function (i) {
      $(this).find(".card-body .items .count").after($(this).find(".card-body .items .count .text"));
      $(this).find(".card-body .header .delete").after("<div class='price_metr'><span class='text'>Цена</span>" + "<span>" + $(this).find(".card-header .price_metr").text() + "</span>" + "<span class='m2'>/м2</span>");
    });
  }
}

function productCardMore1023() {
  if (!$(".card-product .card-header .items>.count").length) {
    $(".card-product_bottom .card").each(function (i) {
      $(this).find('.card-header .items>.price_metr').after($(this).find('.card-body .items .count'));
      $(this).find('.card-header .items>.count').after($(this).find('.card-body .items .total'));
      $(this).find('.card-header .items>.total').after($(this).find('.card-body .items .delete'));
      $(this).find('.collapse').html('');
    });
  }
}

function productCard1023() {
  if (!$('.accordion-add-product .collapse>.card-body').length) {
    $('.accordion-add-product .collapse').html("\n\t\t\t<div class=\"card-body\">\n\t\t\t\t<div class=\"header\">\n\t\t\t\t\t<div class=\"count\">\u041A\u043E\u043B\u0438\u0447\u0435\u0441\u0442\u0432\u043E</div>\n\t\t\t\t\t<div class=\"total\">\u0421\u0443\u043C\u043C\u0430</div>\n\t\t\t\t\t<div class=\"delete\">&nbsp;</div>\n\t\t\t\t</div>\n\t\t\t\t<div class=\"items\"></div>\n\t\t\t\t<div class=\"footer\">\n\t\t\t\t\t<a class=\"clear\" href=\"#\">\u041E\u0447\u0438\u0441\u0442\u0438\u0442\u044C</a>\n\t\t\t\t</div>\n\t\t\t</div>\n\t");
    $('.accordion-add-product .card').each(function (i) {
      $(this).find('.card-header .items .count,' + '.card-header .items .total,' + '.card-header .items .delete').prependTo($(this).find('.card-body .items'));
    });
  }
}

function productCard1150() {
  if (!$('.card-product>.text').length) $(".card-product").prepend($(".card-product_top .item.item_specifications .header .text"));
}

function productCard1150More() {
  if (!$('.card-product_top>.item_specifications>.header>.text').length) $(".card-product_top>.item_specifications>.header").prepend($(".card-product>.text"));
}

function catalogModalAdaptive767More() {
  $('.accordion .card').each(function (i, elem) {
    if (i !== 0) {
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