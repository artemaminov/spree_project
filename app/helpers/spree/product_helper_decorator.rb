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

end
