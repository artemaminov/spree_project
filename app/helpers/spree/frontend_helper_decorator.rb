Spree::FrontendHelper.module_eval do
  def spree_breadcrumbs(taxon, separator = '/')
    return '' if current_page?('/') || taxon.nil?

    separator = raw(content_tag(:span, separator))
    crumbs = [link_to(Spree.t(:home), spree.root_path, itemprop: 'url') + separator]
    if taxon
      # crumbs << link_to(Spree.t(:products), spree.products_path, itemprop: 'url') + separator
      crumbs << taxon.ancestors.collect { |ancestor| link_to(ancestor.name, seo_url(ancestor), itemprop: 'url') + separator } unless taxon.ancestors.empty?
      crumbs << link_to(taxon.name, seo_url(taxon), itemprop: 'url')
      if @product
        crumbs << separator + content_tag(:span, @product.name)
      end
    else
      crumbs << Spree.t(:products)
    end
    content_tag(:div, raw(crumbs.flatten.map(&:mb_chars).join), class: 'breadcrumbs', itemscope: 'itemscope', itemtype: 'https://schema.org/BreadcrumbList')
  end

  def in_stock_text(product)
    product.in_stock? ? Spree.t('in_stock') : Spree.t('out_of_stock')
  end
end