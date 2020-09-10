Spree::FrontendHelper.module_eval do
  def spree_breadcrumbs(crumb, child = '', options = { class: 'breadcrumbs' })
    return '' if current_page?('/') || crumb.nil?

    separator = '/'

    separator = raw(content_tag(:span, separator))
    crumbs = [link_to(Spree.t(:home), spree.root_path, itemprop: 'url') + separator]

    if crumb.is_a?(Spree::Taxon)
      # crumbs << link_to(Spree.t(:products), spree.products_path, itemprop: 'url') + separator
      crumbs << crumb.ancestors.collect { |ancestor| link_to(ancestor.name, seo_url(ancestor), itemprop: 'url') + separator } unless crumb.ancestors.empty?

      if @product
        crumbs << link_to(crumb.name, seo_url(crumb), itemprop: 'url')
        crumbs << separator + content_tag(:span, @product.name)
      else
        crumbs << content_tag(:span, crumb.name)
      end
    else

      if child.blank?
        crumbs << content_tag(:span, Spree.t(crumb))
      else
        crumbs << link_to(Spree.t(crumb), "/#{controller_name}", itemprop: 'url') + separator
        crumbs << content_tag(:span, child)
      end
      # crumbs << content_tag(:span, Spree.t(:products))
    end
    content_tag(:div, raw(crumbs.flatten.map(&:mb_chars).join), options, itemscope: 'itemscope', itemtype: 'https://schema.org/BreadcrumbList')
  end

  def in_stock_text(product)
    product.in_stock? ? Spree.t('in_stock') : Spree.t('backorder')
  end

  # Compile product dimensions popover
  def formats_dimensions(product)
    options = Spree::OptionValue.where(presentation: fetch_options(product))
    output = %{(
      <div class='popover_products'>
        <div class='item item_header'>
          <div class='title'>Форматы</div>
          <div class='format'>Размеры</div>
        </div>
    )}
    options.each do |option|
      output += %{(
        <div class='item'>
          <div class='title'>#{option.presentation}</div>
          <div class='format'>#{option.dimension} мм</div>
        </div>
      )}
    end
    output += '</div>'
  end

  # Fetch all product variants format option values
  def fetch_options(product)
    options = []
    product.variants_and_option_values(current_currency).each do |variant|
      options << variant.option_value('format')
    end
    options
  end

  # Get all option value in one line semicolon divided
  def option_values_text(product)
    options = fetch_options(product)
    options.join(', ')
  end
end
