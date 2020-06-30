"use strict";

var isModalOpen = false;
$(document).ready(function () {
  $('.input_phone').inputmask("+7 (999) 999 99 99");
  initHomeSlickSlider();
  showModal('.id_modalRegistrationOpen', '#registration');
  showModal('.id_modalLoginOpen', '#login');
  showModal('.id_modalThankYouOpen', '#thankYou');
  showModal('.id_modalForgotPasswordOpen', '#forgotPassword');
  isShowSidebar();
  showNavigation();
  initPopover();
  initGrid();
});

function initGrid() {
  $('.grid').masonry({
    itemSelector: '.grid-item',
    percentPosition: true // gutter: 10

  });
}

function initPopover() {
  $('[data-toggle="popover"]').popover({
    trigger: 'hover',
    placement: 'top',
    container: 'body',
    html: true
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
  firstSection = $('.section_first-section');
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