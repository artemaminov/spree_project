$(document).on('turbolinks:load', function() {
    $("#menu_about").on("click", function() {
        $(this).toggleClass("show");
        $("#div_about").toggle("slow");
    });

    $("#menu_about").hover(
        function() {},
        function() {
            $("#div_about").mouseleave(function() {
                $(this).hide("slow");
                $("#menu_about").removeClass("show");
            });
        }
    );

    $('.gallery-image').colorbox({rel: '.gallery-image'});
    $('.masonry-image').colorbox();


    $(".news__item").on("click", function() {
        Turbolinks.visit($(this).data("href"));
    });

    $(".button_form").colorbox({
        inline: true,
        width: "500px",
        height: "420px",
        opacity: "0.6"
    });


    $(".modal .input").on("focus", function() {
        $(this)
            .parent()
            .find("span.err")
            .html("&nbsp;");
        $(this)
            .removeClass("err")
            .removeClass("success");
    });

    $(".modal .input").on("input", function() {
        $modal = $(this).parents(".modal");
        if ($(this).val() == "") {
            $(this).addClass("err");
            $(this)
                .parent()
                .find("span.err")
                .text($(this).data("err"));
            $(this)
                .parents(".modal")
                .find(".submit")
                .addClass("disabled")
                .attr("disabled", "disabled");
            return false;
        } else {
            $(this)
                .removeClass("err")
                .addClass("success");
            $(this)
                .parent()
                .find("span.err")
                .html("&nbsp;");
        }

        if (
            $modal.find("input.input").length == $modal.find("input.success").length
        ) {
            $(this)
                .parents(".modal")
                .find(".submit")
                .removeClass("disabled")
                .removeAttr("disabled");
        }
    });

    // bottom unsued partly code

    var z = $(".tovar__formats_format li")
        .first()
        .find("input");

    ShowFormatInfo(z);

    z.trigger("click");

    $(".tovar__formats_format input").on("click", function() {
        ShowFormatInfo($(this));
    });

    function ShowFormatInfo(t) {
        $t = t.parent("li");
        $(".tovar__formats_info-format")
            .removeClass()
            .addClass(
                "tovar__formats_info-format tovar__formats_info-format-" + t.val()
            );

        $("#tovar-format-price").html($t.data("price"));
        $("#tovar-format-price-metr").html($t.data("price-metr"));

        $.each(
            ["size", "qw", "ves", "poddon", "metr", "price", "price-metr"],
            function(i, v) {
                $(".tovar__formats_info-" + v + " .value").html($t.data(v));
            }
        );
    }

    /*$('.div_alt').hover(function(){
				$(this).find('.alt').slideDown();
			}, function(){
				$(this).find('.alt').slideUp();
			})*/

    function returnOptions() {
        var options = $(".ajax-overlay").find(".product-option-wrap");
        $("body").removeClass("ajax-overlay-open");
        $(".products__item").each(function() {
            if ($(this).find(".product-option-wrap").length == 0) {
                $(this).append(options);
                return;
            }
        });
    }

    $(".ajax-overlay_close").on("click touchstart", function(e) {
        e.preventDefault();
        $(".ajax-overlay").removeClass("visible");
        returnOptions();
    });

    $(".quantity").on("change", function() {
        var in_metr = $(this).data("qw");
        var $list = $(this).parents(".list_option");
        if ($(this).hasClass("quantity_st")) {
            var st = $(this).val();
            var metr = parseInt(st / in_metr);
            $list.find(".quantity_m").val(metr);
        } else {
            var metr = $(this).val();
            var st = metr * in_metr;
            $list.find(".quantity_st").val(st);
        }
        var cost = $list.find(".price_format").val();
        $list.find(".summa").html((cost * st).toFixed(1));

        reloadProductOption($(this));
    });

    $(".format_remove").on("click", function() {
        var $parent = $(this).parents(".list_body");
        $parent.find(".quantity_st").val(0);
        $parent.find(".quantity_m").val(0);
        $parent.find(".summa").html(0.0);
        reloadProductOption($(this));
    });

    function reloadProductOption(t) {
        $parent = $(t).parents(".product-options");

        itogo_sum = 0;
        itogo_m = 0;
        itogo_st = 0;

        $parent.find(".list_body").each(function() {
            var z = $(this)
                .find(".summa")
                .html();
            if (z != undefined) itogo_sum = itogo_sum + eval(z);

            var z = $(this)
                .find(".quantity_m")
                .val();
            if (z != undefined) itogo_m = itogo_m + eval(z);

            var z = $(this)
                .find(".quantity_st")
                .val();
            if (z != undefined) itogo_st = itogo_st + eval(z);
        });
        $parent.find(".itogo_st").html(itogo_st);
        $parent.find(".itogo_m").html(itogo_m);
        $parent.find(".itogo_sum").html(itogo_sum.toFixed(1));
    }

    // добавление в корзину

    //

    // фотогалерея товара
    $("#tovar__gallery_slider").slick({
        slidesToShow: 2,
        slidesToScroll: 1,
        prevArrow: $(".products__left-arrow"),
        nextArrow: $(".products__right-arrow"),
        focusOnSelect: true,
        variableWidth: true
    });

    $("#tovar__gallery_slider").on("afterChange", function(
        event,
        slick,
        currentSlide,
        nextSlide
    ) {});

    var bgSlider = $(".first__bg-slider");
    var productsSlide = $(".first__brick");
    var productAnimationSpeed = 1000; // скорость появления товара
    var productDelayBeforeShow = 500; // задержка перед появлением товара после смены фона
    var pruductThumbsSlider = $(".slider__thumbs");
    var pruductThumbsSlider_clone = $(".slider__thumbs .thumbs__div").clone();
    var cardsProductSlider_clone = $(".slider__cards .slider__item").clone();

    // инициализация слайдера фона
    bgSlider.slick({
        autoplay: true,
        autoplaySpeed: 6500,
        speed: 1500,
        arrows: true,
        cssEase: "ease-out",
        dots: true
    });
    // }).slick('slickPause');

    // перед сменой фона сделать невидимым товар
    bgSlider.on("beforeChange", function(
        event,
        slick,
        currentSlide,
        nextSlide
    ) {
        productsSlide
            .eq(currentSlide)
            .animate({ opacity: 0 }, productAnimationSpeed);
    });

    // после смены фона показать товар с задержкой
    bgSlider.on("afterChange", function(event, slick, currentSlide, nextSlide) {
        productsSlide
            .eq(currentSlide)
            .delay(productDelayBeforeShow)
            .animate({ opacity: 1 }, productAnimationSpeed);

        if (!$(".fixed-nav").hasClass("fixed-nav--fixed")) {
            var id = productsSlide.eq(currentSlide).data("category");
            $(".filter__list .filter__item").removeClass("filter__item--active");
            $('.filter__list .filter__item[data-id="' + id + '"]').addClass(
                "filter__item--active"
            );
        }
    });

    // // novelty desc slider
    // $(".novelty__desc-slider").slick({
    //     slidesToShow: 1,
    //     fade: true,
    //     arrows: false
    // });
    //
    // // novelty image slider
    // $(".novelty__slider").slick({
    //     dots: true,
    //     dotsClass: "slider-dot",
    //     appendDots: ".novelty__dots",
    //     arrows: true,
    //     prevArrow: $(".novelty__nav > .left-arrow"),
    //     nextArrow: $(".novelty__nav > .right-arrow"),
    //     focusOnSelect: true,
    //     asNavFor: ".novelty__desc-slider"
    // });

    //копируем слайдеры для фильтра

    // products thumbnail slider
    pruductThumbsSlider.slick({
        centerMode: true,
        slidesToShow: 11,
        slidesToScroll: 4,
        arrows: false,
        asNavFor: ".slider__cards",
        focusOnSelect: true
    });

    pruductThumbsSlider.on("afterChange", function(event, slick, currentSlide) {
        var id = $(
            '.slick-track .slick-slide.slick-current.slick-active[data-slick-index="' +
            currentSlide +
            '"]'
        ).data("category");

        if (
            $(".filter__list .filter__item.filter__item--active").data("id") != id
        ) {
            $(".filter__list .filter__item").removeClass("filter__item--active");
            $('.filter__list .filter__item[data-id="' + id + '"]').addClass(
                "filter__item--active"
            );
        }
    });

    // products cards slider
    $(".slider__cards").slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        prevArrow: $(".products__left-arrow"),
        nextArrow: $(".products__right-arrow"),
        asNavFor: ".slider__thumbs",
        focusOnSelect: true
    });

    // feedback attachments slider
    $(".feedback__pics").slick({
        slidesToShow: 3,
        slidesToScroll: 1,
        prevArrow: $(".feedback__left-arrow"),
        nextArrow: $(".feedback__right-arrow"),
        focusOnSelect: true,
        asNavFor: ".feedback__reviews"
    });

    // feedback reviews slider
    $(".feedback__reviews").slick({
        asNavFor: ".feedback__pics",
        fade: true,
        arrows: false
    });

    // // news slider
    // $(".news__slider").slick({
    //     slidesToShow: 2,
    //     slidesToScroll: 1,
    //     prevArrow: $(".news__left-arrow"),
    //     nextArrow: $(".news__right-arrow")
    // });

    // gallery slider
    $(".gallery__slider").slick({
        slidesToShow: 4,
        slidesToScroll: 2,
        prevArrow: $(".gallery__left-arrow"),
        nextArrow: $(".gallery__right-arrow")
    });

    $("select").each(function() {
        var $this = $(this),
            numberOfOptions = $(this).children("option").length;

        $this.addClass("select-hidden");
        $this.wrap('<div class="select"></div>');
        $this.after('<div class="select-styled"></div>');

        var $styledSelect = $this.next("div.select-styled");

        $styledSelect.text(
            $this
                .children("option")
                .eq(0)
                .text()
        );

        var $list = $("<ul />", {
            class: "select-options"
        }).insertAfter($styledSelect);

        for (var i = 0; i < numberOfOptions; i++) {
            $("<li />", {
                text: $this
                    .children("option")
                    .eq(i)
                    .text(),
                rel: $this
                    .children("option")
                    .eq(i)
                    .val()
            }).appendTo($list);
        }

        var $listItems = $list.children("li");

        $styledSelect.click(function(e) {
            e.stopPropagation();
            $("div.select-styled.active")
                .not(this)
                .each(function() {
                    $(this)
                        .removeClass("active")
                        .next("ul.select-options")
                        .hide();
                });
            $(this)
                .toggleClass("active")
                .next("ul.select-options")
                .toggle();
        });

        $listItems.click(function(e) {
            e.stopPropagation();
            $styledSelect.text($(this).text()).removeClass("active");
            $this.val($(this).attr("rel"));
            $list.hide();

            var filterSlides = pruductThumbsSlider_clone.clone();
            var filterCardsSlides = cardsProductSlider_clone.clone();

            $.each(["category", "format", "size", "color"], function(i, k) {
                var $b = $("#" + k);
                var clas = "";
                if ($b.length > 0) {
                    var v = $b.val();
                    if (v != "hide" && v != "0") {
                        var cl = k + v;
                        filterSlides = filterSlides.filter("." + cl);
                        filterCardsSlides = filterCardsSlides.filter("." + cl);
                    }
                }
            });

            pruductThumbsSlider
                .slick("unslick")
                .empty()
                .append(filterSlides)
                .slick({
                    centerMode: true,
                    slidesToShow: 11,
                    slidesToScroll: 4,
                    arrows: false,
                    asNavFor: ".slider__cards",
                    focusOnSelect: true
                });

            $(".slider__cards")
                .slick("unslick")
                .empty()
                .append(filterCardsSlides)
                .slick({
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    prevArrow: $(".products__left-arrow"),
                    nextArrow: $(".products__right-arrow"),
                    asNavFor: ".slider__thumbs",
                    focusOnSelect: true
                });

            var arrZ = ["format", "size"];
            var $m1 = new Array();
            $m1[0] = [];
            $m1[1] = [];
            $m1[2] = [];

            $(
                ".slider__cards.slick-initialized.slick-slider .slick-track .slider__item"
            ).each(function(ind, block) {
                $.each(arrZ, function(i, k) {
                    var v = $(block).data(k);
                    if (v != "" && v != undefined) {
                        $m1[i][ind] = v;
                    }
                });
            });

            $.each(arrZ, function(i, k) {
                var $m2 = $.unique($m1[i]);
                var $sel = $("#" + k)
                    .parents(".select")
                    .find("ul.select-options li");
                $sel.each(function() {
                    var v = $(this).attr("rel");
                    $(this).removeClass("disabled");
                    if (v != 0) {
                        if ($.inArray(v, $m2) !== -1) {
                        } else {
                            $(this).addClass("disabled");
                        }
                    }
                });
            });
        });

        $(document).click(function() {
            $styledSelect.removeClass("active");
            $list.hide();
        });
    });

    $(document).on(
        "click",
        ".slider__cards .slick-slide.slick-current.slick-active",
        function() {
            location.href = $(this).data("href");
        }
    );


    $(".filter__list .filter__item a").on("click", function() {
        $("div.select-styled").each(function() {
            $(this)
                .removeClass("active")
                .next("ul.select-options")
                .find("li")
                .removeClass("disabled");
            var t = $(this)
                .removeClass("active")
                .next("ul.select-options")
                .find('li[rel="hide"]')
                .text();
            $(this).text(t);
        });

        var filterSlides = pruductThumbsSlider_clone.clone();
        var filterCardsSlides = cardsProductSlider_clone.clone();

        pruductThumbsSlider
            .slick("unslick")
            .empty()
            .append(filterSlides)
            .slick({
                centerMode: true,
                slidesToShow: 11,
                slidesToScroll: 4,
                arrows: false,
                asNavFor: ".slider__cards",
                focusOnSelect: true
            });

        $(".slider__cards")
            .slick("unslick")
            .empty()
            .append(filterCardsSlides)
            .slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                prevArrow: $(".products__left-arrow"),
                nextArrow: $(".products__right-arrow"),
                asNavFor: ".slider__thumbs",
                focusOnSelect: true
            });

        $(".filter__list .filter__item").removeClass("filter__item--active");
        $(this)
            .parent()
            .addClass("filter__item--active");

        top_p = $(".products").offset().top;
        height_p = $(".first__filter").height();

        if ($(".fixed-nav").hasClass("fixed-nav--fixed")) {
            topp = top_p - 3 * height_p;
        } else topp = top_p - 4 * height_p;

        $("html, body").animate({ scrollTop: topp }, 500);
        id = $(this)
            .parent()
            .data("id");
        var $t = $('.slick-track .thumbs__div[data-category="' + id + '"]')
            .not(".slick-cloned")
            .first();
        $(".slider__thumbs").slick("slickGoTo", $t.data("slick-index"));
    });

    function init_arraw() {
        $this = $(".filter__list .filter__item.filter__item--active a");
        pos_a = $this.position();
        left_a = pos_a["left"] + $this.width() / 2;
        $("#arrow_product").css("left", left_a + "px");
        if ($(".fixed-nav").hasClass("fixed-nav--fixed")) {
            $("#arrow_product").css("top", -pos_a["top"] + "px");
        } else $("#arrow_product").css("top", -(pos_a["top"] * 2) + "px");
    }
});