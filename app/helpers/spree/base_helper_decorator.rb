Spree::BaseHelper.module_eval do
  def resize_to_fill(image, options)
    image.variant(combine_options: { resize: "#{ options[:resize] }^", gravity: 'Center', crop: "#{ options[:crop] }" }).processed
  end
end
