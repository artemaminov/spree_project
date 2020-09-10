Spree::ProductsHelper.module_eval do
  ICONS_FOLDER = 'icons/format/'
  FALLBACK_ICON = 'icon-add-product.svg'

  # Get variant icon if present or stub
  def variant_icon(variant)
    icon = variant.option_value('format', :icon) || ''
    icons_path = ICONS_FOLDER + icon
    if icon.empty? || Rails.application.assets_manifest.assets[icons_path].nil?
      image_tag ICONS_FOLDER + FALLBACK_ICON
    else
      image_tag icons_path
    end
  end

  def product_img_tag(image, product, options, style, crop_opts)
    options[:alt] = image.alt.blank? ? product.name : image.alt

    crop_opts.blank? ?
        image_tag(main_app.url_for(image.url(style)), options)
        :
        image_tag(main_app.url_for(resize_to_fill(image.url(style).blob, crop_opts)), options)
  end

  def product_image(product, *options)
    style = 'product'
    options = options.first || {}
    options[:alt] ||= product.name
    crop_opts = options[:crop_opts] || {}
    options.delete(:crop_opts)
    # { resize: '590x551', crop: '590x551+0+0' }
    if product.images.empty?
      if !product.is_a?(Spree::Variant) && !product.variant_images.empty?
        product_img_tag(product.variant_images.first, product, options, style, crop_opts)
      else
        if product.is_a?(Spree::Variant) && !product.product.variant_images.empty?
          product_img_tag(product.product.variant_images.first, product, options, style, crop_opts)
        else
          image_tag "noimage/#{style}.png", options
        end
      end
    else
      product_img_tag(product.images.first, product, options, style, crop_opts)
    end
  end

end
