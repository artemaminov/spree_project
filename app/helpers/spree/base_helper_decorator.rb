Spree::BaseHelper.module_eval do
  def resize_to_fill(image, options)
    image.variant(combine_options: { resize: "#{ options[:resize] }^", crop: "#{ options[:crop] }"}).processed
  end

  def fill_to_resize(image, options)
    image.variant(combine_options: { crop: "#{ options[:crop] }", resize: "#{ options[:resize] }^"}).processed
  end
end
