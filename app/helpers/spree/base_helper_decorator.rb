Spree::BaseHelper.module_eval do
  def resize_to_fill(image, size)
    image.variant(combine_options: { resize: "#{ size }^", gravity: 'Center', crop: "#{ size }+0+0" }).processed
  end
end
