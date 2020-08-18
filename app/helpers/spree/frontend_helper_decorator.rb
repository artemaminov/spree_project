Spree::FrontendHelper.module_eval do
  def spree_breadcrumbs(taxon, separator = '/')
    return '' if current_page?('/') || taxon.nil?

    separator = raw(separator)
    crumbs = [content_tag(:span, link_to(content_tag(:span, Spree.t(:home), itemprop: 'name'), spree.root_path, itemprop: 'url') + separator, itemprop: 'item')]
    if taxon
      crumbs << content_tag(:span, link_to(content_tag(:span, Spree.t(:products), itemprop: 'name'), spree.products_path, itemprop: 'url') + separator, itemprop: 'item')
      crumbs << taxon.ancestors.collect { |ancestor| content_tag(:span, link_to(content_tag(:span, ancestor.name, itemprop: 'name'), seo_url(ancestor), itemprop: 'url') + separator, itemprop: 'item') } unless taxon.ancestors.empty?
      crumbs << content_tag(:span, link_to(content_tag(:span, taxon.name, itemprop: 'name'), seo_url(taxon), itemprop: 'url'), itemprop: 'item')
    else
      crumbs << content_tag(:span, Spree.t(:products), itemprop: 'item')
    end
    content_tag(:div, raw(crumbs.flatten.map(&:mb_chars).join), class: 'breadcrumbs', itemscope: 'itemscope', itemtype: 'https://schema.org/BreadcrumbList')
  end

  def in_stock_text(product)
    product.in_stock? ? Spree.t('in_stock') : Spree.t('out_of_stock')
  end
end