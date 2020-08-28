Spree::ProductsHelper.module_eval do
  ICONS_FOLDER = "icons/format/"

  def option_values_text(product)
    options = fetch_options(product)
    options.join(', ')
  end

  def variant_icon(variant)
    icon = variant.option_value('format', :icon)
    icons_path = ICONS_FOLDER + icon
    if icon.empty? || Rails.application.assets_manifest.find_sources(icons_path).empty?
      image_tag ICONS_FOLDER + 'icon-add-product.svg'
    else
      image_tag icons_path
    end
  end

  def formats_dimensions(product)
    options = Spree::OptionValue.where(presentation: fetch_options(product))
    output = %{
      <div class='popover_products'>
        <div class='item item_header'>
          <div class='title'>Форматы</div>
          <div class='format'>Размеры</div>
        </div>
    }
    options.each do |option|
      output += %{
        <div class='item'>
          <div class='title'>#{option.presentation}</div>
          <div class='format'>#{option.dimension} мм</div>
        </div>
      }
    end
    output += '</div>'
  end

  def fetch_options(product)
    options = []
    product.variants_and_option_values(current_currency).each do |variant|
      options << variant.option_value('format')
    end
    options
  end
end
