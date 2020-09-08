$(function () {
  $(document).ajaxStart(function () {
    // $('#progress').stop(true, true).fadeIn()
  })
  $(document).ajaxStop(function () {
    // $('#progress').fadeOut()
  })
})


$(document).ready(function () {
  const body = $('body');

  const colors_filter = $('.colors')
  const formats_filter = $('.formats')
  const form = $('#sidebar_products_search')

  colors_filter.find('input[type="checkbox"]').on('change', function(){
    // let _this = $(this);
    // let values = colors_filter
    //     .find('input:checked')
    //     .map(function(){return $(this).val()})
    //     .get()

    products_reloading(form)
    // console.log(form.serializeArray())
  })

  formats_filter.find('input[type="checkbox"]').on('change', function(){
    let _this = $(this);

    // let value = _this.val();

    formats_filter
        .find('input[type="checkbox"]')
        .not(_this)
        .prop('checked', false)

    products_reloading(form)
    // console.log(form.serializeArray())
  })
});

var xhr_run = null

function products_reloading(form) {

  if (xhr_run !== null) {
    xhr_run.abort();
    xhr_run = null;
  }

  $('.ajax-load').show();

  xhr_run = $.ajax({
    url: '/taxons_by_filter',
    type: 'GET',
    data: form.serializeArray(),
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
  }).done(function(result){
    window.history.pushState('', '', '?' + form.serialize())

    showModal('.id_modalAddCollection', '#addCollection');
    initGrid();
    initPopover();

    $('.ajax-load').hide();
    // modalAddProductInitAndDestroy();
    // initTabForAddProductModal();
    // modalAddProductInitAndDestroy();
    // initTabForAddProductModal();
    // initAccordionAddCollection();
    // initAccordionProduct();
    // initAccordionAddProduct();
    // initAccordionDelivery();
    // initAccordionProductMap();
    // initBasketSteps();
    // initDeliveryBasket();
    // initFillingOutFormBasket();
    // initHeightForAccordionProduct();
    // initMapForCatalog();

  }).fail(function(result){
    console.log(result);
  });
}

