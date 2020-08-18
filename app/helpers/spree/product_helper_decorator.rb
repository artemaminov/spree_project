Spree::ProductsHelper.module_eval do
  def option_values_text(product)
    options = []
    product.variants_and_option_values(current_currency).each do |variant|
      options << variant.option_value('format')
    end
    options.join(', ')
  end
end
