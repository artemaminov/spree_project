"use strict";

var isModalOpen = false;

(function (e, p) {
  e.extend({
    lockfixed: function lockfixed(a, b) {
      b && b.offset ? (b.offset.bottom = parseInt(b.offset.bottom, 10), b.offset.top = parseInt(b.offset.top, 10)) : b.offset = {
        bottom: 100,
        top: 0
      };

      if ((a = e(a)) && a.offset()) {
        var n = a.css("position"),
            c = parseInt(a.css("marginTop"), 10),
            l = a.css("top"),
            g = a.offset().top,
            h = !1;
        if (!0 === b.forcemargin || navigator.userAgent.match(/\bMSIE (4|5|6)\./) || navigator.userAgent.match(/\bOS ([0-9])_/) || navigator.userAgent.match(/\bAndroid ([0-9])\./i)) h = !0;
        e(window).bind("scroll resize orientationchange load lockfixed:pageupdate", a, function (k) {
          if (!h || !document.activeElement || "INPUT" !== document.activeElement.nodeName) {
            var d = 0,
                d = a.outerHeight();
            k = a.outerWidth();
            var m = e(document).height() - b.offset.bottom,
                f = e(window).scrollTop();
            "fixed" != a.css("position") && (g = a.offset().top, c = parseInt(a.css("marginTop"), 10), l = a.css("top"));
            f >= g - (c ? c : 0) - b.offset.top ? (d = m < f + d + c + b.offset.top ? f + d + c + b.offset.top - m : 0, h ? a.css({
              marginTop: parseInt((c ? c : 0) + (f - g - d) + 2 * b.offset.top, 10) + "px"
            }) : a.css({
              position: "fixed",
              top: b.offset.top - d + "px",
              width: k + "px"
            })) : a.css({
              position: n,
              top: l,
              width: k + "px",
              marginTop: (c ? c : 0) + "px"
            });
          }
        });
      }
    }
  });
})(jQuery);

$(document).ready(function () {
  initInputMask();
  initHomeSlickSlider();
  showModal('.id_modalRegistrationOpen', '#registration');
  showModal('.id_modalLoginOpen', '#login');
  showModal('.id_modalThankYouOpen', '#thankYou');
  showModal('.id_modalForgotPasswordOpen', '#forgotPassword');
  showModal('.id_modalAddProduct', '#addProduct');
  showModal('.id_modalAddCollection', '#addCollection');
  isShowSidebar();
  showNavigation();
  initPopover();
  initGrid();
  modalAddProductInitAndDestroy();
  initTabForAddProductModal();
  initAccordionAddCollection();
  initAccordionProduct();
  initAccordionAddProduct();
  initAccordionDelivery();
  initAccordionProductMap();
  initBasketSteps();
  initDeliveryBasket();
  initFillingOutFormBasket();
});

function initFillingOutFormBasket() {
  var fillingOutForm = $("input[name*='fillingOutForm']");
  checkedFillingOutForm(fillingOutForm.val());
  fillingOutForm.on("click", function () {
    var val = $(this).val();
    checkedFillingOutForm(val);
  });
}

function checkedFillingOutForm(val) {
  if (Number(val) === 2) {
    $(".filling-out-form .form-basket").html("\n    <div class=\"form-row\">\n      <div class=\"form-group col-md-6\">\n        <label for=\"innBasket\">\u0418\u041D\u041D*</label>\n        <input class=\"form-control\" id=\"innBasket\" type=\"text\" placeholder=\"\u0412\u0432\u0435\u0434\u0438\u0442\u0435 \u0418\u041D\u041D \u043A\u043E\u043C\u0430\u043F\u043D\u0438\u0438\">\n      </div>\n      <div class=\"form-group col-md-6\">\n        <label for=\"phoneNumberBasket\">\u041D\u043E\u043C\u0435\u0440 \u0442\u0435\u043B\u0435\u0444\u043E\u043D\u0430*</label>\n        <input class=\"form-control\" id=\"phoneNumberBasket\" type=\"text\" placeholder=\"\u0412\u0432\u0435\u0434\u0438\u0442\u0435 \u0442\u0435\u043B\u0435\u0444\u043E\u043D\" inputmode=\"text\">\n      </div>\n    </div>\n    <div class=\"form-row\">\n      <div class=\"form-group col-md-6\">\n        <label for=\"fioBasket\">\u0424\u0430\u043C\u0438\u043B\u0438\u044F \u0418\u043C\u044F \u041E\u0442\u0447\u0435\u0441\u0442\u0432\u043E*</label>\n        <input class=\"form-control\" id=\"fioBasket\" type=\"text\" placeholder=\"\u0418\u0432\u0430\u043D\u043E \u0418\u0432\u0430\u043D \u0418\u0432\u0430\u043D\u043E\u0432\u0438\u0447\">\n      </div>\n      <div class=\"form-group col-md-6\">\n        <label for=\"emailBasket\">\u042D\u043B\u0435\u043A\u0442\u0440\u043E\u043D\u043D\u0430\u044F \u043F\u043E\u0447\u0442\u0430*</label>\n        <input class=\"form-control\" id=\"emailBasket\" type=\"text\" placeholder=\"your@email.com\">\n      </div>\n    </div>\n    ");
    $(".filling-out-form .wrapper").removeClass("left").addClass("right");
  } else {
    $(".filling-out-form .form-basket").html("\n    <div class=\"form-row\">\n      <div class=\"form-group col-md-6\">\n        <label for=\"fioBasket\">\u0424\u0430\u043C\u0438\u043B\u0438\u044F \u0418\u043C\u044F \u041E\u0442\u0447\u0435\u0441\u0442\u0432\u043E*</label>\n        <input class=\"form-control\" id=\"fioBasket\" type=\"text\" placeholder=\"\u0418\u0432\u0430\u043D\u043E \u0418\u0432\u0430\u043D \u0418\u0432\u0430\u043D\u043E\u0432\u0438\u0447\">\n      </div>\n      <div class=\"form-group col-md-6\">\n        <label for=\"phoneNumberBasket\">\u041D\u043E\u043C\u0435\u0440 \u0442\u0435\u043B\u0435\u0444\u043E\u043D\u0430*</label>\n        <input class=\"form-control\" id=\"phoneNumberBasket\" type=\"text\" placeholder=\"\u0412\u0432\u0435\u0434\u0438\u0442\u0435 \u0442\u0435\u043B\u0435\u0444\u043E\u043D\" inputmode=\"text\">\n      </div>\n    </div>\n    <div class=\"form-row\">\n      <div class=\"form-group col-md-6\">\n        <label for=\"emailBasket\">\u042D\u043B\u0435\u043A\u0442\u0440\u043E\u043D\u043D\u0430\u044F \u043F\u043E\u0447\u0442\u0430*</label>\n        <input class=\"form-control\" id=\"emailBasket\" type=\"text\" placeholder=\"your@email.com\">\n      </div>\n    </div>\n    ");
    $(".filling-out-form .wrapper").removeClass("right").addClass("left");
  }
}

function initDeliveryBasket() {
  var valueDelivery = $("input[name*='delivery-basket']");
  checkedDelivery(valueDelivery.val());
  valueDelivery.on("click", function () {
    var val = $(this).val();
    checkedDelivery(val);
  });
}

function checkedDelivery(valueDelivery) {
  if (Number(valueDelivery) === 2) {
    // $(".selected-store_block").show();
    // $(".select-address_block").hide();
    $(".selected-store_block").addClass("active");
    $(".select-address_block").removeClass("active");
  } else {
    // $(".selected-store_block").hide();
    // $(".select-address_block").show();
    $(".selected-store_block").removeClass("active");
    $(".select-address_block").addClass("active");
  }
}

function initBasketSteps() {
  $(".js-btnNextBasketSteps").on("click", function () {
    $(this).parent().parent().parent().parent().removeClass("active").next().addClass("active");
  });
  $(".js-btnBackBasketSteps").on("click", function () {
    $(this).parent().parent().parent().parent().removeClass("active").prev().addClass("active");
  });
}

function initAccordionProductMap() {
  $(".section_map .dealer-list .item").on("click", function () {
    if (!$(this).hasClass("active")) {
      $(".section_map .dealer-list .item").removeClass("active");
      $(this).addClass("active");
    } else {
      $(".section_map .dealer-list .item").removeClass("active");
    }
  });
}

function initAccordionDelivery() {
  var accordion = $('#accordionDelivery');
  accordion.on('shown.bs.collapse', function () {
    addDeleteActiveDelivery();
  });
  accordion.on('hidden.bs.collapse', function () {
    addDeleteActiveDelivery();
  });
}

function addDeleteActiveDelivery() {
  var items = $('.accordion-delivery .card-header .items');
  items.parent().parent().removeClass('active');
  items.each(function () {
    if (!$(this).hasClass('collapsed')) {
      $(this).parent().parent().addClass('active');
    }
  });
}

function initAccordionAddProduct() {
  var accordion = $('#accordionAddProduct');
  accordion.on('shown.bs.collapse', function () {
    addDeleteActiveForProduct();
  });
  accordion.on('hidden.bs.collapse', function () {
    addDeleteActiveForProduct();
  });
}

function addDeleteActiveForProduct() {
  var items = $('.accordion-add-product .card-header .items');
  items.parent().parent().removeClass('active');
  items.each(function (i, elem) {
    if (!$(this).hasClass('collapsed')) {
      $(this).parent().parent().addClass('active');
    }
  });
}

function initAccordionAddCollection() {
  var accordion = $('#accordionAddCollection');
  accordion.on('shown.bs.collapse', function () {
    addDeleteActiveForAccordion();
  });
  accordion.on('hidden.bs.collapse', function () {
    addDeleteActiveForAccordion();
  });
}

function addDeleteActiveForAccordion() {
  var items = $('.accordion .card .card-header .items');
  items.parent().parent().removeClass('active');
  items.each(function (i, elem) {
    if (!$(this).hasClass('collapsed')) {
      $(this).parent().parent().addClass('active');
    }
  });
}

function initAccordionProduct() {
  $(".js-accordion-product>.header").on("click", function () {
    if ($(this).parent().hasClass("active")) $(this).parent().removeClass("active");else $(this).parent().addClass("active");
  });
}

function changeUnitPrice(unit) {
  var price = $(unit).data("price");
  $('#piece-price').html("".concat(price.piece, "<span>\u20BD/\u0448\u0442.</span>"));
  $('#sqr-meter-price').html("".concat(price.sqrMeter, "<span>\u20BD/\u043C<sup>2</sup></span>"));
}

function initTabForAddProductModal() {
  $('#tabProduct li, #tabProduct li input').on('click', function (e) {
    $(this).find('a').tab('show');
    $(this).closest('ul').find('input[type="radio"]').prop('checked', '');
    $(this).closest('li').find('input[type="radio"]').prop('checked', 'checked');
    changeUnitPrice(this);
  });
}

function initInputMask() {
  $('.input_phone').inputmask("+7 (999) 999 99 99");
  $('#phoneNumberBasket').inputmask("+7 (999) 999 99 99");
}

function modalAddProductInitAndDestroy() {
  $(document).on('shown.bs.modal', function (e) {
    if (e.target.id === 'addProduct') {
      initAddProductSliderMini();
      initAddProductSlider();
    }
  });
  $(document).on('hidden.bs.modal', function (e) {
    if (e.target.id === 'addProduct') {
      destroyAddProductSlider('.slider_add-product');
      destroyAddProductSlider('.slider_add-product_mini');
    }
  });
}

function initGrid() {
  var grid = $('.grid').imagesLoaded().progress(function () {
    $('.grid').masonry({
      itemSelector: '.grid-item',
      percentPosition: true,
      columnWidth: '.persent-size' // gutter: 10

    });
  });
}

function initPopover() {
  $('[data-toggle="popover"]').popover({
    trigger: 'hover',
    placement: 'top',
    container: 'body',
    html: true,
    boundary: 'window'
  });
}

function isShowSidebar() {
  $('.close_sidebar').on('click', function () {
    closeSidebar();
  });
  $(document).mouseup(function (e) {
    var block = $('.sidebar_block');
    if (!block.is(e.target) && block.has(e.target).length === 0) closeSidebar();
  });
  $('.burger').on('click', function (e) {
    isModalOpen = true;
    e.preventDefault();
    $('html').css('overflow', 'hidden');
    $('.sidebar').addClass('active');
    $('.sidebar_block').addClass('active');
    initSidebarSlider();
  });
}

function initAddProductSliderMini() {
  $('.slider_add-product_mini').slick({
    arrows: false,
    dots: false,
    fade: false,
    autoplay: false,
    slidesToShow: 5,
    slidesToScroll: 1,
    vertical: true,
    verticalSwiping: true,
    asNavFor: '.slider_add-product',
    focusOnSelect: true,
    responsive: [{
      breakpoint: 1439,
      settings: {
        slidesToShow: 3
      }
    }]
  });
}

function initAddProductSlider() {
  $('.slider_add-product').slick({
    arrows: false,
    dots: false,
    fade: true,
    autoplay: false,
    slidesToShow: 1,
    slidesToScroll: 1,
    swipe: false,
    asNavFor: '.slider_add-product_mini'
  });
}

function destroyAddProductSlider(obj) {
  $(obj).slick('unslick');
}

function initHomeSlickSlider() {
  $('.sliders').slick({
    arrows: false,
    dots: true,
    fade: true,
    autoplay: false,
    autoplaySpeed: 5000,
    appendDots: '.section_first-section .container-xl'
  });
}

function initSidebarSlider() {
  var $sidebar_slider_frame = $('#sidebar_slider');
  var $sidebar_slider_wrap = $sidebar_slider_frame.parent();
  sliderOption($sidebar_slider_frame, $sidebar_slider_wrap.find('.scrollbar'));
}

function closeSidebar() {
  $('html').css('overflow', 'visible');
  $('.sidebar').removeClass('active');
  $('.sidebar_block').removeClass('active');
  destroySidebarSlider();
}

function destroySidebarSlider() {
  $('#sidebar_slider').sly(false);
}

function sliderOption($slider_frame, $slider_wrap) {
  return $slider_frame.sly({
    horizontal: 1,
    itemNav: 'basic',
    smart: 1,
    mouseDragging: 1,
    touchDragging: 1,
    releaseSwing: 1,
    scrollBar: $slider_wrap,
    scrollBy: 100,
    speed: 300,
    elasticBounds: 1,
    easing: 'easeOutExpo',
    dragHandle: 1,
    dynamicHandle: 1,
    clickBar: 1
  });
}

function showNavigation() {
  var oldY = 0;
  var firstSection = null,
      positionBottomFirstSection = null;
  firstSection = $('#first-section');
  positionBottomFirstSection = firstSection.outerHeight();
  window.addEventListener('scroll', function () {
    var coordinates = document.documentElement.getBoundingClientRect();
    if (coordinates.y <= -5) $('.header_first').css('transform', 'translateY(-148px)');else $('.header_first').css('transform', 'translateY(0)');

    if (coordinates.y < -positionBottomFirstSection && oldY < coordinates.y) {
      $('.header_second').css('transform', 'translateY(0)');
    } else {
      $('.header_second').css('transform', 'translateY(-148px)');
    }

    oldY = coordinates.y;
  });
}

function showModal() {
  var idClick = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : '';
  var idModal = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : '';
  $(idClick).on('click', function (e) {
    e.preventDefault();
    $('div').modal('hide');
    $(idModal).modal('show');
  });
}